//
//  TravelLogViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/23/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import Domain
import SnapKit
import RxSwift
import UIKit

public protocol TravelLogViewControllerDelgate {
    func showBottomSheet()
    func navigateToCreateScreen()
    func navigateToDetailTravelLogView(to log : Log)
}

public class TravelLogViewController: BaseViewController{
    
    let travelView = TravelLogView()
    let viewModel : TravelLogViewModel
    
    public var coordinator : TravelLogViewControllerDelgate?
    
    public init(viewModel: TravelLogViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        viewModel.loadLogs()
    }
    
    public override func setFunc(){
        viewModel.logs
            .bind(to: travelView.gridView.rx.items(cellIdentifier: LogCollectionViewCell.cellId, cellType: LogCollectionViewCell.self)) { index, item, cell in
                cell.bind(log: item, isBigCell: false)
            }
            .disposed(by: disposeBag)
        
        travelView.gridView.rx
            .modelSelected(Log.self)
            .subscribe{ [weak self] log in
                self?.coordinator?.navigateToDetailTravelLogView(to: log)
            }
            .disposed(by: disposeBag)
        
        travelView.button
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.coordinator?.showBottomSheet()
            }
            .disposed(by: disposeBag)
    }
    
    public override func setUp(){
        view.addSubview(travelView)
    }
    
    public override func setUpViewProperty() {
        view.backgroundColor = .white
    }
    
    public override func setLayout(){
        travelView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TravelLogViewController : NewLogSheetDelegate {
    public func showCreateLogScreen() {
        coordinator?.navigateToCreateScreen()
    }
    
    public func joinLog(invitationCode: String) {
        viewModel.joinLog(invitationCode)
    }
}
