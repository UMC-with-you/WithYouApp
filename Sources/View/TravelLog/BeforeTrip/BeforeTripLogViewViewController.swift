//
//  BeforeTripLogViewViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/16/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import SnapKit
import RxCocoa
import RxSwift
import UIKit

class BeforeTripLogViewViewController: UIViewController {
    //D-day
    let day = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 32)
        label.textColor = .black
        return label
    }()
    
    var profilePic = ProfileView(size: .small)
    
    let sideMenu = UIImageView(image: UIImage(named: "SideMenu"))
    
    //Log title
    //아래 줄 생성 예정
    let logTitle = {
       let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 20)
        label.textColor = .black
        return label
    }()
    //Notice
    let noticeView = NoticeView()
    
    //Packing Together
    let packingContainer = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = WithYouAsset.subColor.color.cgColor
        container.layer.borderWidth = 1.0
        container.layer.cornerRadius = 15
        container.clipsToBounds = true
        return container
    }()
    
    let packingHeader = {
        let section = TwoComponentLineView("Packing Together", imageView: UIImageView(image: UIImage(named: "PackingIcon")))
        section.changeConst {
            section.imageView.snp.updateConstraints{
                $0.width.height.equalTo(32)
            }
        }
        section.label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        return section
    }()
    
    let packingListView = {
        //CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 40)
        
        let list = UICollectionView(frame: .zero,collectionViewLayout: layout)
        list.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        list.register(PackingTableCell.self, forCellWithReuseIdentifier: PackingTableCell.cellId)
        return list
    }()
    
    //Add package
    var addPackageWidthConstraint : Constraint?
    let addPackageContainer = {
       let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.layer.cornerRadius = 10
        return uv
    }()
    let textField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.placeholder = "짐 추가하기"
        textField.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        textField.textColor = WithYouAsset.mainColorDark.color
        return textField
    }()
    let addPackageButton = WYAddButton(.small)
    
    //기능 구현 변수들
    var log : Log?
    
    //PackingItem
    let packingManager = PackingItemManager()
    var packingItems = PublishSubject<[PackingItem]>()
    var packageText = ""
    //Travel Members
    var travelMembers = [Traveler]()

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        setUp()
        setConst()
        setDelegate()
        setFunc()
        setInfo()
        
        addPackageButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                self.addButtonClicked()
            })
            .disposed(by: disposeBag)
    }
    
    private func setInfo(){
        logTitle.text = log?.title
        day.text = dateController.days(from: log?.startDate ?? "오류")
        
        //여행 멤버 불러오기
        LogService.shared.getAllMembers(logId: self.log!.id){ response in
            self.travelMembers = response
            self.loadPackingItems()
        }
        
        //PackingItemCollectionView cell mapping
        packingItems
            .bind(to: packingListView.rx.items(cellIdentifier: PackingTableCell.cellId, cellType: PackingTableCell.self)) { index, item, cell in
                cell.bind(travelers: self.travelMembers, packingItem: item,manager: self.packingManager)
            }
        .disposed(by: disposeBag)
        
    }
    
    private func setFunc(){
        //짐 추가 텍스트필드 선택 시 입력창 위로 옮기기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        sideMenu.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                 self.openSideMenu()
            })
            .disposed(by: disposeBag)
        
        //서버에서 packingItem 변경시 새로고침
        packingManager.itemChangedNotify.subscribe { _ in
            self.loadPackingItems()
        }
        .disposed(by: disposeBag)
    }
    
    private func setDelegate(){
        noticeView.delegate = self
        textField.delegate = self
        
        //당겨서 새로고침
        packingListView.refreshControl = UIRefreshControl()
        packingListView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        packingListView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setUp(){
        [day,logTitle,noticeView,packingContainer,addPackageContainer].forEach{
            view.addSubview($0)
        }
        
        //Packing Together
        [packingHeader,packingListView].forEach{
            packingContainer.addSubview($0)
        }
        
        //AddPackage
        [textField,addPackageButton].forEach{
            addPackageContainer.addSubview($0)
        }
        
        //NavigationBar
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: sideMenu),
            UIBarButtonItem(customView: ProfileView(size: .small, traveler: Traveler(id: 0, name: DataManager.shared.getUserName())))]
    }
    
    private func setConst(){
        
        day.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        sideMenu.snp.makeConstraints{
            $0.width.height.equalTo(30)
            
        }
        
        logTitle.snp.makeConstraints{
            $0.leading.equalTo(day)
            $0.top.equalTo(day.snp.bottom).offset(20)
        }
        
        //NoticeView
        noticeView.snp.makeConstraints{
            $0.top.equalTo(logTitle.snp.bottom).offset(15)
            $0.bottom.equalTo(packingContainer.snp.top).offset(-30)
            $0.width.equalTo(packingContainer.snp.width)
            $0.centerX.equalToSuperview()
        }
        
        //Packing Together List
        packingContainer.snp.makeConstraints{
            $0.width.equalTo(addPackageContainer.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(addPackageContainer.snp.top).offset(-20)
        }
        packingHeader.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }
        packingListView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(packingHeader.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
        
        //Adding Package
        addPackageContainer.snp.makeConstraints{ make in
            addPackageWidthConstraint =  make.width.equalToSuperview().multipliedBy(0.9).constraint
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            //추후 위의 뷰와 거리 계산
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        textField.snp.makeConstraints{
            $0.width.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(46)
        }
        
        addPackageButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func loadPackingItems(){
        packingManager.updateItemFromServer(travelId: self.log!.id){
            let item = self.packingManager.getItemList()
            if !item.isEmpty {
                self.packingItems.onNext(item)
            }
        }
    }
    
    //PackingItem 추가 버튼 클릭시
    private func addButtonClicked(){
        guard let itemName = self.textField.text else {return}
        if itemName.count > 0 {
            PackingItemService.shared.addItem(travelId: self.log!.id, itemName: itemName){ response in
                self.loadPackingItems()
                self.textField.text = ""
            }
        } else {
            let alert = UIAlertController(title: "실패", message: "정확한 이름을 써주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    //사이드바 열기
    func openSideMenu(){
        let sideMenu = SideBarViewController()
        sideMenu.modalPresentationStyle = .overFullScreen
        //Log 전달
        sideMenu.bind(log: self.log!,members: self.travelMembers)
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        present(sideMenu,animated: false)
    }
    
    //PackingItem 당겨서 새로고침
    @objc func handleRefreshControl(){
        loadPackingItems()
        DispatchQueue.main.async{
            self.packingListView.refreshControl?.endRefreshing()
        }
    }
}


// MARK: TextFieldDelegate
extension BeforeTripLogViewViewController: UITextFieldDelegate{
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 필드의 편집이 종료될 때 호출되는 메서드
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing")
    }
    
    // return button 눌렀을 떄
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyBoardHeight = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyBoardHeight.cgRectValue.height
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

//MARK: CollectionViewDelegate
extension BeforeTripLogViewViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        false
    }
}

extension BeforeTripLogViewViewController : NoticeViewDelegate {
    //노티스 생성
    func addNotice() {
        let addNoticeView = AddNoticeViewController()
        addNoticeView.modalPresentationStyle = .overFullScreen
        
        addNoticeView.noticeAdder.subscribe(onNext: { noticeDic in
            LogService.shared.getAllMembers(logId: self.log!.id){ response in
                let memberId = response[0].id
                print(memberId)
                NoticeService.shared.createNotice(info: noticeDic, memberId: memberId, logId: self.log!.id){ response in
                }
            }
            
        })
        .disposed(by: disposeBag)
        
        present(addNoticeView, animated: false)
    }
}

