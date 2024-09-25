//
//  OnGoingTravelViewController.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import UIKit

public protocol OnGoingTravelViewControllerDelgate {
    func navigateToCreatRewind(log : Log)
}

final public class OnGoingTravelViewController : BaseViewController {
    
    private let onGoingView = OnGoingTravelView()
    let addNoticeView = AddNoticeView()
    
    private let viewModel : OnGoingTravelViewModel
    
    public var coordinator : OnGoingTravelViewControllerDelgate?
    
    init(viewModel: OnGoingTravelViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNotices()
    }
    
    override public func setUpViewProperty() {
        view.backgroundColor = WithYouAsset.backgroundColor.color
//        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: sideMenu), UIBarButtonItem(customView: ProfileView(size: .small, traveler: Traveler(id: 0, name: DataManager.shared.getUserName())))]
    }
     
    override public func setFunc() {
        
        ///Notice 관련
        viewModel.notices
            .bind(to: onGoingView.noticeView.tableView.rx.items(cellIdentifier: NoticeTableCell.cellId, cellType: NoticeTableCell.self)){ index, notice, cell in
                cell.bind(notice: notice)
            }
            .disposed(by: disposeBag)
        
        //Notice 체크버튼 클릭
        onGoingView.noticeView
            .tableView
            .rx
            .modelSelected(Notice.self)
            .withUnretained(self)
            .subscribe(onNext:{ (owner, notice) in
                owner.viewModel.checkNotice(noticeId: notice.noticeID)
            })
            .disposed(by: disposeBag)
        
        //Notice 삭제
        onGoingView.noticeView
            .tableView
            .rx
            .modelDeleted(Notice.self)
            .withUnretained(self)
            .subscribe(onNext: { (owner, notice) in
                owner.viewModel.deleteNotice(noticeId: notice.noticeID)
            })
            .disposed(by: disposeBag)
        
        //NoticeAddView 보이기 버튼
        onGoingView.noticeView
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
        
        
         onGoingView.rewindView.rx
             .tapGesture()
             .when(.recognized)
             .withUnretained(self)
             .subscribe{ (owner, _) in
                 print("RewindButton Touched")
                 owner.coordinator?.navigateToCreatRewind(log: owner.viewModel.log)
             }
             .disposed(by: disposeBag)
         
         onGoingView.chatView.rx
             .tapGesture()
             .when(.recognized)
             .subscribe{ _ in
                
             }
             .disposed(by: disposeBag)
         
         onGoingView.sideMenu.rx
             .tapGesture()
             .when(.recognized)
             .subscribe{ _ in
                 //self.openSideMenu()
             }
             .disposed(by: disposeBag)
     }
    override public func setUp() {
        view.addSubview(onGoingView)
        view.addSubview(addNoticeView)
    }
    
    override public func setLayout() {
        onGoingView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        //노티스 추가 창
        addNoticeView.isHidden = true
        addNoticeView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
     
//     func openSideMenu(){
//         let sideMenu = SideBarViewController()
//         sideMenu.modalPresentationStyle = .overFullScreen
//         //Log 전달
//         sideMenu.bind(log: self.log!,members: try! self.travelMembers.value())
//         let transition = CATransition()
//         transition.duration = 0.25
//         transition.type = .fade
//         transition.subtype = .fromRight
//         transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//         view.window?.layer.add(transition, forKey: kCATransition)
//         present(sideMenu,animated: false)
//     }
     
 }
