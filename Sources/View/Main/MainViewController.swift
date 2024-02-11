//
//  ViewController.swift
//
//  Created by 김도경 on 1/8/24.
//

import SnapKit
import RxCocoa
import RxGesture
import RxSwift
import UIKit


class MainViewController: UIViewController {
    let header = TopHeader()

    let button = WYAddButton(.big)
    
    ///Log가 있을 때 보여지는 뷰
    let logViewContainer = UIView()
    
    lazy var logCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.45)
        layout.minimumLineSpacing = 17
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(LogCollectionViewCell.self, forCellWithReuseIdentifier: LogCollectionViewCell.cellId)
        cv.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 30)
        cv.showsHorizontalScrollIndicator = false
        cv.decelerationRate = .fast
        return cv
    }()
    
    let eclipse = {
        let view = UIView()
        view.frame = CGRect(x: 0,y: 0,width: 5,height: 5)
        view.backgroundColor = WithYouAsset.mainColorDark.color
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    let upcoming = {
        let label = UILabel()
        label.text = "UPCOMING"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
        label.textColor = .black
        return label
    }()
    let ing = {
        let label = UILabel()
        label.text = "ING"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
        label.textColor = .black
        return label
    }()
    let sortIcon = {
        let img = UIImageView(image: WithYouAsset.sortIcon.image)
        return img
    }()
    
    
    ///Log가 없을 때 보여지는 뷰
    let emptyLogView = UIView()
    let info = {
       let label = UILabel()
        label.text = "Travel Log를 만들어 \n with 'You'를 시작해보세요!"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.numberOfLines = 2
        label.textColor = UIColor(named: "MainColorDark")
        label.setLineSpacing(spacing: 10)
        label.textAlignment = .center
        return label
    }()
    let mascout = {
        let img = UIImageView(image: UIImage(named: "Mascout"))
        return img
    }()
    
    ///기능 구현을 위한 변수들
    private var eclipseConstraint: Constraint?
    var isLogEmpty : BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var isUpcoming : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var disposeBag = DisposeBag()
    var upcomingLogs : [Log] = []
    var ingLogs : [Log] = []
    var logs : BehaviorRelay<[Log]> = BehaviorRelay(value: [])
    var previousIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.backButtonTitle = "Home"
        logViewContainer.backgroundColor = .systemBackground
        //로그 가져오기
        loadLogs()
        
        // 2. if logs.count != 0 ? 여행중인지 아닌지 판단 후 표시 / default는 여행 중 아님
        setViews()
        setConst()
        setFuncs()
        setSubscribes()
        
        //
        //로그 존재 여부에 따른 화면 표시
        countLogs()
    }
    
    func setSubscribes(){
        //로그 데이터 CollectionView 연결
        logs
            .bind(to: logCollectionView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)){ index, item, cell in
                cell.bind(log: item, isBigCell: true)
                if index != 0{
                    cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)
                }
            }
        .disposed(by: disposeBag)
        
        //터치에 따른 ING or UPCOMING 색 변경
        isUpcoming.subscribe(onNext: {
            if $0 {
                self.ing.textColor = WithYouAsset.subColor.color
                self.upcoming.textColor = WithYouAsset.mainColorDark.color
                self.eclipseConstraint?.deactivate()
                self.eclipse.snp.makeConstraints{ ecl in
                    self.eclipseConstraint = ecl.centerX.equalTo(self.upcoming.snp.centerX).constraint
                }
            } else {
                self.ing.textColor = WithYouAsset.mainColorDark.color
                self.upcoming.textColor = WithYouAsset.subColor.color
                self.eclipseConstraint?.deactivate()
                self.eclipse.snp.makeConstraints{ ecl in
                    self.eclipseConstraint = ecl.centerX.equalTo(self.ing.snp.centerX).constraint
                }
            }
        })
        .disposed(by: disposeBag)
        
        // 로그 존재 여부에 따른 뷰 설정
        isLogEmpty.subscribe(onNext: { isEmpty in
            if isEmpty {
                self.emptyLogView.isHidden = false
                self.logViewContainer.isHidden = true
            } else {
                self.emptyLogView.isHidden = true
                self.logViewContainer.isHidden = false
            }
            self.button.snp.updateConstraints{
                $0.bottom.equalToSuperview().offset(isEmpty ? -280 : -130)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func countLogs(){
        let count = upcomingLogs.count + ingLogs.count
        isLogEmpty.accept(count == 0 ? true : false)
    }
    
    private func loadLogs(){
        //LogManager.shared.updateLogsFromServer()
        //self.logs.accept(LogManager.shared.getLogs())
        self.upcomingLogs = [
            Log(id: 0, title: "친구들과 좋은시간", startDate: "2024.02.08", endDate: "2024.02.010", status: "여행 중", imageUrl: "이미지"),
            Log(id: 1, title: "서울 테스트 아아", startDate: "2024.02.22", endDate: "2024.02.25", status: "여행 전", imageUrl: "이미지"),
            Log(id: 2, title: "배고픈 모임 당산", startDate: "2024.03.01", endDate: "2024.03.06", status: "여행 전", imageUrl: "이미지"),
            Log(id: 3, title: "이태원 뿌시기 모임 가보자", startDate: "2024.03.09", endDate: "2024.03.13", status: "여행 전", imageUrl: "이미지"),
            Log(id: 4, title: "아주좋아 아주좋아", startDate: "2024.03.16", endDate: "2024.03.18", status: "여행 전", imageUrl: "이미지")
        ]
        
        self.ingLogs = [Log(id: 0, title: "친구들과 좋은시간", startDate: "2024.02.08", endDate: "2024.02.010", status: "여행 중", imageUrl: "이미지")]
        
        if ingLogs.count != 0 {
            logs.accept(ingLogs)
        } else {
            logs.accept(upcomingLogs)
            isUpcoming.accept(true)
        }
    }
    
    private func setFuncs(){
        button.rx.tap
            .bind{
            self.popUpLogOption()
        }
        .disposed(by: disposeBag)
        
        ing.rx.tapGesture()
            .when(.recognized)
            .bind{ _ in
                self.ingClicked()
                self.logs.accept(self.ingLogs)
            }
            .disposed(by: disposeBag)

        upcoming.rx.tapGesture()
            .when(.recognized)
            .bind{ _ in
                self.upcomingClicked()
                self.logs.accept(self.upcomingLogs)
            }
            .disposed(by: disposeBag)
    }
    
    private func setViews(){
        logCollectionView.delegate = self
        
        [header,emptyLogView,logViewContainer,button].forEach{
            view.addSubview($0)
        }
        
        //로그 없을 때 보여지는 View
        [mascout,info].forEach {
            emptyLogView.addSubview($0)
        }
        
        //로그가 존재할때 보여지는 View
        [logCollectionView,ing,upcoming,eclipse,sortIcon].forEach {
            logViewContainer.addSubview($0)
        }
    }
    
    private func setConst(){
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        //Log가 비었을 때 뷰
        emptyLogView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalToSuperview()
        }
        
        mascout.snp.makeConstraints{
            $0.height.equalTo(58)
            $0.width.equalTo(115)
            $0.bottom.equalTo(info.snp.top).offset(-35)
            $0.centerX.equalToSuperview()
        }
        
        info.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
        
        //로그가 존재할 때 뷰
        logViewContainer.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        logCollectionView.snp.makeConstraints{
            $0.top.equalTo(ing.snp.bottom).offset(30)
            $0.bottom.equalTo(button.snp.top).offset(-40)
            $0.width.equalToSuperview()
        }
        
        ing.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview().offset(-60)
        }
        
        upcoming.snp.makeConstraints{
            $0.top.equalTo(ing.snp.top)
            $0.leading.equalTo(ing.snp.trailing).offset(50)
        }
        
        eclipse.snp.makeConstraints{
            $0.top.equalTo(ing.snp.bottom).offset(10)
            $0.width.height.equalTo(5)
            self.eclipseConstraint = $0.centerX.equalTo(isUpcoming.value ? upcoming.snp.centerX : ing.snp.centerX).constraint
        }
        
        sortIcon.snp.makeConstraints{
            $0.top.equalTo(ing.snp.top)
            $0.height.equalTo(23)
            $0.width.equalTo(26)
            $0.trailing.equalToSuperview().offset(-20)
        }

        button.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(isLogEmpty.value ? -270 : -130)
        }
    }
}

extension MainViewController{
    // log 만드는 옵션
    func popUpLogOption(){
        let modalVC = NewLogSheetView()
        
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return UIScreen.main.bounds.height / 3.5
        }
        
        if let sheet = modalVC.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
      
        _ =  modalVC.commander.subscribe({ event in
            let newLogVC = CreateTravelLogViewController()
            self.navigationController?.pushViewController(newLogVC, animated: true)
        })

        present(modalVC, animated: true)
    }
    
    // 로그 터치시 해당 로그 상세 페이지로 이동
   func navigateToLog(){
        // 클릭한 log의 정보를 가져와서 열어야함
        // 백엔드측에서는 id로 가져올 수 있음
        // rx사용하면 가능함!
        let logVC = BeforeTripLogViewViewController() // 1.  여기에 ID를 넣어서 controller가 가져오게 하는 방법 ?
        self.navigationController?.pushViewController(logVC, animated: true)
    }
    
    // Upcoming Ing Label 클릭시
    func upcomingClicked(){
        self.isUpcoming.accept(true)
    }
    
    func ingClicked(){
        self.isUpcoming.accept(false)
    }
}

extension MainViewController : UICollectionViewDelegateFlowLayout{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = UIScreen.main.bounds.width * 0.75 + 17
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidth = CGFloat(UIScreen.main.bounds.width * 0.75 + 17)
        let curScrollOffset = scrollView.contentOffset.x + scrollView.contentInset.left
        let index = Int(round(curScrollOffset/cellWidth))
        let indexPath = IndexPath(item: index, section: 0)
        
        if let cell = logCollectionView.cellForItem(at: indexPath) {
            transformCellOriginSize(cell)
        }
        
        defer {
            self.previousIndex = index
        }
        
        guard let previousIndex = self.previousIndex, previousIndex != index else {return}
        if let prevCell = logCollectionView.cellForItem(at: IndexPath(item: previousIndex, section: 0)){
            transformCellMinifyWithAnimation(prevCell)
        }
    }
    
    func transformCellOriginSize( _ cell: UICollectionViewCell) {
       UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseOut, animations: {cell.transform = .identity}) {_ in
         }
     }
    
    func transformCellMinifyWithAnimation(_ cell: UICollectionViewCell) {
          UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseOut, animations: {cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)}) {_ in
            }
        }
}
