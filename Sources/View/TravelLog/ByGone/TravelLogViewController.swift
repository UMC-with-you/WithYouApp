//
//  TravelLogViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/23/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//
import SnapKit
import RxSwift
import UIKit

class TravelLogViewController: BaseViewController{
    
    let header = TopHeader()
    
    let searchBar = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = WithYouAsset.subColor.color.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let searchIcon = UIImageView(image: WithYouAsset.searchIcon.image)
    
    let searchField = {
        let field = UITextField()
        field.placeholder = "검색어를 입력해주세요"
        field.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        field.textColor = WithYouAsset.subColor.color
        field.borderStyle = .none
        return field
    }()
    
    let sortIcon = UIImageView(image: WithYouAsset.sortIcon.image)
    
    lazy var gridView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 225)
        layout.minimumInteritemSpacing = 10
        
        let grid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        grid.register(LogCollectionViewCell.self, forCellWithReuseIdentifier: LogCollectionViewCell.cellId)
        grid.showsVerticalScrollIndicator = false
        return grid
    }()
    
    var logs = BehaviorSubject<[Log]>(value: [])
    
    let button = WYAddButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLogs()
    }
    
   
    
    private func loadLogs(){
        //여기 로그는 여행이 끝난 로그만
        logs.onNext(LogManager.shared.getFinishedLogs())
    }
    
    override func setFunc(){
        logs
            .bind(to: gridView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)) { index, item, cell in
                cell.bind(log: item, isBigCell: false)
            }
            .disposed(by: disposeBag)
        
        gridView.rx
            .modelSelected(Log.self)
            .subscribe{ log in
                self.navigateToWithYou(log: log)
            }
            .disposed(by: disposeBag)
        
        button
            .rx
            .tap
            .subscribe { _ in
                self.popUpLogOption()
            }
            .disposed(by: disposeBag)
    }
    
    private func popUpLogOption(){
        let modalVC = NewLogSheetViewController()
        
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
      
//        // Log 만들기로 Navigate
//        _ = modalVC.commander.subscribe({ event in
//            let newLogVC = CreateTravelLogViewController()
//            self.navigationController?.pushViewController(newLogVC, animated: true)
//        })

        present(modalVC, animated: true)
    }
    
    private func navigateToWithYou(log : Log){
        let logVC = ByGoneTripLogViewController()
        logVC.bindLog(log: log)
        self.navigationController?.pushViewController(logVC, animated: true)
    }
    
    override func setUp(){
        [header,searchBar,sortIcon,gridView,button].forEach {
            view.addSubview($0)
        }
        [searchIcon,searchField].forEach{
            searchBar.addSubview($0)
        }
    }
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
    }
    
    override func setLayout(){
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        sortIcon.snp.makeConstraints{
            $0.width.height.equalTo(28)
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
        }
        //SearchBar
        searchBar.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(sortIcon.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        searchIcon.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        searchField.snp.makeConstraints{
            $0.leading.equalTo(searchIcon.snp.trailing).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerY.equalToSuperview()
        }
        
        gridView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        button.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}
