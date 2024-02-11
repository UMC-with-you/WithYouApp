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
    var packageText = ""
    let addPackageButton = WYAddButton(.small)
    
    var dummyData = PublishSubject<[PackingItem]>()

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        setUp()
        setConst()
        setDelegate()
        
        day.text = "D-20"
        logTitle.text = "오징어들의 오사카 여행"

        
        //Testing
        /*
        let packingItemList = [
            PackingItem(id: 0,itemName: "드라이기",isChecked: false),
            PackingItem(id: 1,  itemName: "로션",isChecked: false),
            PackingItem(id: 2,  itemName: "샴푸",isChecked: false),
            PackingItem(id: 3, itemName: "수건",isChecked: false)
        ]
         */
        
        let dummyTravler = [
            Traveler(id: 0, name: "박우주", profilePicture: ""),
            Traveler(id: 1, name: "우박주", profilePicture: ""),
            Traveler(id: 2, name: "주박우", profilePicture: ""),
            Traveler(id: 3, name: "우우우", profilePicture: "")
        ]
        
       //loadPackingItems()
        
        //CollectionView Style
        dummyData
            .bind(to: packingListView.rx.items(cellIdentifier: PackingTableCell.cellId, cellType: PackingTableCell.self)) { index, item, cell in
                cell.itemName.text = item.itemName
                cell.bindTravlers(travelers: dummyTravler)
            }
            .disposed(by: disposeBag)
        
        addPackageButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                self.addButtonClicked()
            })
            .disposed(by: disposeBag)
    }
    
    
    private func setDelegate(){
        noticeView.delegate = self
        textField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        sideMenu.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                 self.openSideMenu()
            })
            .disposed(by: disposeBag)
    }
    
    
    private func setUp(){
        [day,sideMenu,logTitle,noticeView,packingContainer,addPackageContainer].forEach{
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
    }
    
    private func setConst(){
        
        day.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        sideMenu.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
    
    }
    func addButtonClicked(){
        let url = "http://54.150.234.75:8080/api/v1/travels/3/packing_items"
        
        var parameter = [
            "itemName" : ""
        ]
        if let itemName = self.textField.text {
            parameter["itemName"] = itemName
            print(parameter)
        }

        
        /*
        APIManager.shared.postData(urlEndPoint: url, dataType: Log.self, responseType: packingResponse.self) { container in
            print(container.result.packingItemId)
            self.loadPackingItems()
        }
         */
    }
    
    func openSideMenu(){
        let sideMenu = SideBarViewController()
        sideMenu.modalPresentationStyle = .overFullScreen
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        present(sideMenu,animated: false)
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

extension BeforeTripLogViewViewController : NoticeViewDelegate{
    func addNotice() {
        let addNoticeView = AddNoticeViewController()
        addNoticeView.modalPresentationStyle = .overFullScreen
        present(addNoticeView, animated: false)
    }
}
