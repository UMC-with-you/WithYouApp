//
//  BeforeTravelLogViewController.swift
//  HomeFeature
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import Domain
import Foundation
import RxSwift
import UIKit

public protocol BeforeTravelLogViewControllerDelgate : AnyObject {
    func openSideMenu(travelers : [Traveler])
    func dismissView()
}

public class BeforeTravelLogViewController : BaseViewController {
    
    let sideMenu = UIImageView(image: WithYouAsset.sideMenu.image)
    
    let beforeTravelLogView = BeforeTravelLogView()
    let addNoticeView = AddNoticeView()
    let viewModel : BeforeTravelLogViewModel
    
    weak public var coordinator : BeforeTravelLogViewControllerDelgate?
    
    public init(viewModel: BeforeTravelLogViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        coordinator?.dismissView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNotices()
        viewModel.getTravelers()
        viewModel.getPackingItems()
        bindLog()
    }
    
    private func bindLog() {
        beforeTravelLogView.day.text = viewModel.log.startDate.getDdays()
        beforeTravelLogView.logTitle.text = viewModel.log.title
    }
    
    override public func setFunc() {
        //Notice View에 Notice 연결
        viewModel.notices
            .bind(to: beforeTravelLogView.noticeView.tableView.rx.items(cellIdentifier: NoticeTableCell.cellId, cellType: NoticeTableCell.self)){ index, notice, cell in
                cell.bind(notice: notice)
            }
            .disposed(by: disposeBag)
        
        //NoticeAddView 보이기 버튼
        beforeTravelLogView.noticeView
            .addButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner, _) in
                owner.addNoticeView.isHidden = false
            }
            .disposed(by: disposeBag)
        
        //AddNotice 뷰 취소
        addNoticeView
            .closeButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner, _) in
                owner.addNoticeView.isHidden = true
            }
            .disposed(by: disposeBag)
        
        //Notice Create 버튼
        addNoticeView
            .createButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner, _) in
                if !(owner.addNoticeView.createButton.backgroundColor == WithYouAsset.subColor.color) {
                    owner.viewModel.addNotice(state: owner.addNoticeView.button.titleLabel?.text ?? "",
                                             content: owner.addNoticeView.textView.text)
                    owner.addNoticeView.isHidden = true
                    owner.addNoticeView.setTextFieldForReuse()
                }
            }
            .disposed(by: disposeBag)
        
        //Notice 체크버튼 클릭
        beforeTravelLogView.noticeView
            .tableView
            .rx
            .modelSelected(Notice.self)
            .withUnretained(self)
            .subscribe(onNext:{ (owner, notice) in
                owner.viewModel.checkNotice(noticeId: notice.noticeID)
            })
            .disposed(by: disposeBag)
        
        //Notice 삭제
        beforeTravelLogView.noticeView
            .tableView
            .rx
            .modelDeleted(Notice.self)
            .withUnretained(self)
            .subscribe(onNext: { (owner, notice) in
                owner.viewModel.deleteNotice(noticeId: notice.noticeID)
            })
            .disposed(by: disposeBag)
        
        // 키보드 위치 옮기기
        Observable
            .combineLatest(
                beforeTravelLogView
            .textField
            .rx
            .controlEvent(.editingDidBegin), 
                beforeTravelLogView
                .textField
                .rx
                .controlEvent(.editingDidEnd))
            .withUnretained(self)
            .subscribe { (owner,event) in
                owner.beforeTravelLogView.moveTextField(owner.view.keyboardLayoutGuide)
            }
            .disposed(by: disposeBag)

        sideMenu
            .rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (owner,_) in
                owner.coordinator?.openSideMenu(travelers: owner.viewModel.travelers)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .packingItems
            .bind(to: beforeTravelLogView.packingListView.rx.items(cellIdentifier: PackingTableCell.cellId, cellType: PackingTableCell.self)){ index, item, cell in
                cell.bind(travelers: self.viewModel.travelers, packingItem: item)
            }
            .disposed(by: disposeBag)
    }
    
    override public func setUp() {
        view.addSubview(beforeTravelLogView)
        view.addSubview(addNoticeView)
    }
    
    override public func setLayout() {
        beforeTravelLogView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        //노티스 추가 창
        addNoticeView.isHidden = true
        addNoticeView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // MockData Inside
    public override func setUpViewProperty() {
        view.backgroundColor = .white
        
        let profileView = ProfileView(size: .small)
        profileView.bindTraveler(traveler: Traveler(id: 3, name: "테스트"))
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: sideMenu), UIBarButtonItem(customView: profileView)]
    }
}
