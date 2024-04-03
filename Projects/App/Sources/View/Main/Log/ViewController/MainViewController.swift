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


class MainViewController: BaseViewController {
    let header = TopHeader()
    let button = WYAddButton(.big)
    
    let emptyLogView = EmptyLogView()
    let mainLogView = MainLogView()
    
    ///기능 구현을 위한 변수들
    var isLogEmpty : BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var isUpcoming : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var upcomingLogs : [Log] = []
    var ingLogs : [Log] = []
    var logs : BehaviorRelay<[Log]> = BehaviorRelay(value: [])
    var previousIndex : Int?
    var previousLogCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //로그 가져오기
        loadLogs()
        setActions()
        setSubscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLogs()
    }
    
    ///데이터 변경시
    private func setSubscribes(){
        //로그 데이터 CollectionView 연결
        logs
            .bind(to: mainLogView.logCollectionView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)){ index, item, cell in
                cell.bind(log: item, isBigCell: true)
                if index != self.previousIndex{
                    cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)
                }
                
                cell.rx.longPressGesture().when(.recognized)
                    .subscribe{ _ in
                        let alert = UIAlertController(title: "삭제", message: "셀을 삭제 하시겠습니까?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .destructive,handler: { _ in
                            LogService.shared.deleteLog(logId: item.id){ _ in
                                self.loadLogs()
                            }
                        }))
                        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                        self.present(alert, animated: true)
                    }
                    .disposed(by: cell.bag)
            }
        .disposed(by: disposeBag)
        
        //LogCell 터치 navigation
//        logCollectionView.rx.modelSelected(Log.self)
//            .subscribe{ log in
//                self.navigateToLog(log: log)
//            }
//            .disposed(by: disposeBag)
        
        //터치에 따른 ING or UPCOMING 색 변경
//        isUpcoming.subscribe(onNext: {
//            if $0 {
//                self.ing.textColor = WithYouAsset.subColor.color
//                self.upcoming.textColor = WithYouAsset.mainColorDark.color
//                self.eclipseConstraint?.deactivate()
//                self.eclipse.snp.makeConstraints{ ecl in
//                    self.eclipseConstraint = ecl.centerX.equalTo(self.upcoming.snp.centerX).constraint
//                }
//            } else {
//                self.ing.textColor = WithYouAsset.mainColorDark.color
//                self.upcoming.textColor = WithYouAsset.subColor.color
//                self.eclipseConstraint?.deactivate()
//                self.eclipse.snp.makeConstraints{ ecl in
//                    self.eclipseConstraint = ecl.centerX.equalTo(self.ing.snp.centerX).constraint
//                }
//            }
//        })
//        .disposed(by: disposeBag)
        
        // 로그 존재 여부에 따른 뷰 설정
        isLogEmpty.subscribe(onNext: { isEmpty in
            if isEmpty {
                self.emptyLogView.isHidden = false
                self.mainLogView.isHidden = true
            } else {
                self.emptyLogView.isHidden = true
                self.mainLogView.isHidden = false
            }
            self.button.snp.updateConstraints{
                $0.bottom.equalToSuperview().offset(isEmpty ? -280 : -130)
            }
        })
        .disposed(by: disposeBag)
    }
    
    ///사용자 터치 이벤트 관련
    private func setActions(){
        //Log 추가 버튼
        button.rx.tap
            .bind{
            self.popUpLogOption()
        }
        .disposed(by: disposeBag)
        mainLogView.ing
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(){ _ in
                self.mainLogView.moveEclipse(false)
            }
            .disposed(by: disposeBag)
        
        mainLogView.upcoming
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(){ _ in
                self.mainLogView.moveEclipse(true)
            }
            .disposed(by: disposeBag)
    }
    
    private func countLogs(){
        let count = upcomingLogs.count + ingLogs.count
        isLogEmpty.accept(count == 0 ? true : false)
    }
    
    private func loadLogs(){
//        LogManager.shared.updateLogsFromServer { logs in
//            if self.previousLogCount != logs.count {
//                self.ingLogs = []
//                self.upcomingLogs = []
//                self.previousIndex = logs.count
//                logs.forEach{ log in
//                    if log.status == "ONGOING"{
//                        self.ingLogs.append(log)
//                    } else if log.status == "UPCOMING" {
//                        self.upcomingLogs.append(log)
//                    }
//                }
//                
//                if self.ingLogs.count != 0 {
//                    self.logs.accept(self.ingLogs)
//                    self.isUpcoming.accept(false)
//                } else {
//                    self.logs.accept(self.upcomingLogs)
//                    self.isUpcoming.accept(true)
//                }
//                self.countLogs()
//            }
//        }
        let testLog = Log(id: 0, title: "테스트중", startDate: "2024-03-23", endDate: "2024-03-31", status: "ONGOING", imageUrl: "")
        self.logs.accept([testLog])
        isLogEmpty.accept(false)
    }
    
    
    override func setUp() {
        [header,emptyLogView,mainLogView,button].forEach{
            view.addSubview($0)
        }
    }
    override func setDelegate() {
        mainLogView.logCollectionView.delegate = self
    }
    override func setLayout() {
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        //로그가 존재할 때 뷰
        emptyLogView.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainLogView.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        button.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(isLogEmpty.value ? -270 : -130)
        }
    }
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
        self.navigationItem.backButtonTitle = "Home"
    }
}

extension MainViewController{
    // log 만드는 옵션
    private func popUpLogOption(){
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
      
        // Log 만들기로 Navigate
        _ = modalVC.commander.subscribe({ event in
            let newLogVC = CreateTravelLogViewController()
            self.navigationController?.pushViewController(newLogVC, animated: true)
        })

        present(modalVC, animated: true)
    }
    
    // 로그 터치시 해당 로그 상세 페이지로 이동
    private func navigateToLog(log : Log){
        if log.status == "UPCOMING"{
            let logVC = BeforeTripLogViewViewController()
            logVC.log = log
            self.navigationController?.pushViewController(logVC, animated: true)
        } else {
            let nextVC = WithUViewController()
            nextVC.log = log
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    // Upcoming Ing Label 클릭시
    private func upcomingClicked(){
        self.isUpcoming.accept(true)
    }
    
    private func ingClicked(){
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
        
        if let cell = mainLogView.logCollectionView.cellForItem(at: indexPath) {
            transformCellOriginSize(cell)
        }
        
        defer {
            self.previousIndex = index
        }
        
        guard let previousIndex = self.previousIndex, previousIndex != index else {return}
        if let prevCell = mainLogView.logCollectionView.cellForItem(at: IndexPath(item: previousIndex, section: 0)){
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
