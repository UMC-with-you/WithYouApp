//
//  TravelLogViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/23/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import SnapKit
import RxSwift
import UIKit

class GridTravelLogViewController: BaseViewController{
    
    let travelView = GridTravelLogView()
    
    let viewModel = GridTravelLogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getLogs()
    }
    
    override func setFunc(){
        viewModel.logs
            .bind(to: travelView.gridView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)) { index, item, cell in
                cell.bind(log: item, isBigCell: false)
            }
            .disposed(by: disposeBag)
        
        travelView.gridView.rx
            .modelSelected(Log.self)
            .subscribe{ log in
                self.navigateToWithYou(log: log)
            }
            .disposed(by: disposeBag)
        
        travelView.button
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
        view.addSubview(travelView)
    }
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
    }
    
    override func setLayout(){
        travelView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
