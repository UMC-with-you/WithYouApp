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

public protocol HomeViewControllerDelgate {
    func showBottomSheet()
    func navigateToCreateScreen()
    func navigateToBeforeTravelView(log : Log)
}

public class HomeViewController: BaseViewController {
    private let header = TopHeader()
    private let button = WYAddButton(.big)
    
    private let emptyLogView = HomeEmptyLogView()
    private let mainLogView = HomeLogView()
    
    private let viewModel : HomeLogViewModel
    public var coordinator : HomeViewControllerDelgate?
    
    ///기능 구현을 위한 변수들
    private var previousIndex : Int?
    private var previousLogCount = 0
    
    public init(viewModel : HomeLogViewModel){
        self.viewModel = viewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setActions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        viewModel.loadLogs()
        viewModel.ingTapped()
        mainLogView.moveEclipse(state: true)
    }
    
    // MARK: Rx연결
    public override func setFunc(){
        viewModel.logs
            .bind(to: mainLogView.logCollectionView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)) { index, item, cell in
                cell.bind(log: item, isBigCell: true)
            }
            .disposed(by: disposeBag)
        
        mainLogView.logCollectionView
            .rx
            .modelSelected(Log.self)
            .subscribe { [weak self] log in
                self?.coordinator?.navigateToBeforeTravelView(log: log)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLogEmpty
            .subscribe { [weak self] isLogEmpty in
                self?.configureViewByLog(isLogEmpty)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: 사용자 터치 이벤트
    private func setActions(){
        //Log 추가 버튼
        button
            .rx
            .tap
            .bind{
                self.coordinator?.showBottomSheet()
        }
        .disposed(by: disposeBag)
        
        Observable.merge(
            mainLogView.upcoming.rx
                .tapGesture()
                .when(.recognized)
                .map{$0.view},
            mainLogView.ing.rx
                .tapGesture()
                .when(.recognized)
                .map{$0.view})
        .withUnretained(self)
        .subscribe { (owner, view) in
            if view == owner.mainLogView.ing {
                owner.viewModel.ingTapped()
                owner.mainLogView.moveEclipse(state: true)
            } else {
                owner.viewModel.upcomingTapped()
                owner.mainLogView.moveEclipse(state: false)
            }
        }
        .disposed(by: disposeBag)
    }
    
    // MARK: ViewController 셋팅
    public override func setUp() {
        [header,emptyLogView,mainLogView,button].forEach{
            view.addSubview($0)
        }
    }
    
    public override func setDelegate() {
        mainLogView.logCollectionView.delegate = self
    }
    
    public override func setLayout() {
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        emptyLogView.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainLogView.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(button.snp.top)
        }
        
        button.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-270)
        }
    }
    
    public override func setUpViewProperty() {
        view.backgroundColor = .white
        self.navigationItem.backButtonTitle = "Home"
    }
}

// MARK: ViewController 메서드
extension HomeViewController{
    
    //Log 유무에 따른 뷰 설정
    private func configureViewByLog(_ isLogEmpty: Bool){
        if isLogEmpty {
            self.emptyLogView.isHidden = false
            self.mainLogView.isHidden = true
        } else {
            self.emptyLogView.isHidden = true
            self.mainLogView.isHidden = false
        }
        
        self.button.snp.updateConstraints{
            $0.bottom.equalToSuperview().offset(isLogEmpty ? -280 : -130)
        }
    }
}

// MARK: NewLogSheetDelgate
extension HomeViewController : NewLogSheetDelegate {
    public func showCreateLogScreen() {
        coordinator?.navigateToCreateScreen()
    }
    
    public func joinLog(invitationCode : String){
        viewModel.joinLog(invitationCode)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
//    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
//        let cellWidth = UIScreen.main.bounds.width * 0.75 + 17
//        let index = round(scrolledOffsetX / cellWidth)
//        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
//    }
//    
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let cellWidth = CGFloat(UIScreen.main.bounds.width * 0.75 + 17)
//        let curScrollOffset = scrollView.contentOffset.x + scrollView.contentInset.left
//        let index = Int(round(curScrollOffset/cellWidth))
//        let indexPath = IndexPath(item: index, section: 0)
//        
//        if let cell = mainLogView.logCollectionView.cellForItem(at: indexPath) {
//            transformCellOriginSize(cell)
//        }
//        
//        defer {
//            self.previousIndex = index
//        }
//        
//        guard let previousIndex = self.previousIndex, previousIndex != index else {return}
//        if let prevCell = mainLogView.logCollectionView.cellForItem(at: IndexPath(item: previousIndex, section: 0)){
//            transformCellMinifyWithAnimation(prevCell)
//        }
//    }
    
    func transformCellOriginSize( _ cell: UICollectionViewCell) {
       UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseOut, animations: {cell.transform = .identity}) {_ in
         }
     }
    
    func transformCellMinifyWithAnimation(_ cell: UICollectionViewCell) {
          UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseOut, animations: {cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)}) {_ in
            }
        }
}


//로그 데이터 CollectionView 연결
//        logs
//            .bind(to: mainLogView.logCollectionView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)){ index, item, cell in
//                cell.bind(log: item, isBigCell: true)
//                if index != self.previousIndex{
//                    cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)
//                }
//
//                cell.rx
//                    .longPressGesture()
//                    .when(.recognized)
//                    .subscribe{ _ in
//                        let alert = UIAlertController(title: "삭제", message: "셀을 삭제 하시겠습니까?", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "확인", style: .destructive,handler: { _ in
//                            LogService.shared.deleteLog(logId: item.id){ _ in
//                                self.loadLogs()
//                            }
//                        }))
//                        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
//                        self.present(alert, animated: true)
//                    }
//                    .disposed(by: cell.bag)
//            }
//        .disposed(by: disposeBag)
