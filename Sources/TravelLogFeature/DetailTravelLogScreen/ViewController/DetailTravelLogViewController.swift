//
//  DetailTravelLogViewController.swift
//  TravelLogFeature
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//




import RxGesture
import RxSwift
import RxCocoa
import UIKit
import SnapKit

public protocol DetailTravelViewDelegate {
    func navigateToPostList()
}

public class DetailTravelLogViewController: BaseViewController {
    
    private let detailView = DetailTravelLogView()
    private let viewModel : DetailTravelViewModel
    private let log : Log
    
    public var delegate : DetailTravelViewDelegate?
    
    public init(viewModel: DetailTravelViewModel, log: Log){
        self.viewModel  = viewModel
        self.log = log
        super.init()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        bindLog()
        getTraveler()
    }
    
    public func getTraveler() {
        viewModel.getTravelerInfo(travelId: log.id)
    }
    
    public func bindLog() {
        detailView.topTitleLabel.text = log.title
        detailView.dateLabel.text = "\(log.startDate.replacingOccurrences(of: "-", with: ".")) - \(log.endDate.replacingOccurrences(of: "-", with: ".")) "
    }
    
    override public func setFunc() {
        viewModel.travelersRelay
            .bind(to: detailView.memberCollectionView.rx.items(cellIdentifier: MemberCell.id, cellType: MemberCell.self)){ index, traveler, cell in
                cell.bind(traveler: traveler)
            }
            .disposed(by: disposeBag)
        
        detailView.postBookView
            .rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (owner,_) in
                owner.delegate?.navigateToPostList()
            }
            .disposed(by: disposeBag)
        
        detailView.rewindBookView
            .rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (owner,_) in
                print("rewindBookTapped")
            }
            .disposed(by: disposeBag)
        
        detailView.sideMenu.rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe{ (owner,_) in
                owner.openSideMenu()
            }
            .disposed(by: disposeBag)
    }
    
    override public func setUp() {
        view.addSubview(detailView)
    }
    
    override public func setLayout() {
        detailView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    override public func setUpViewProperty() {
        view.backgroundColor = .white
        let profileView = ProfileView(size: .small)
        profileView.bindTraveler(traveler: Traveler(id: 3, name: "테스트"))
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: detailView.sideMenu), UIBarButtonItem(customView: profileView)]
    }
    
    func openSideMenu(){
        print("OpenSideMenu")
//        let sideMenu = SideBarViewController()
//        sideMenu.modalPresentationStyle = .overFullScreen
//        //Log 전달
//        sideMenu.bind(log: self.log!,members: try! self.travelMembers.value())
//        let transition = CATransition()
//        transition.duration = 0.25
//        transition.type = .fade
//        transition.subtype = .fromRight
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        view.window?.layer.add(transition, forKey: kCATransition)
//        present(sideMenu,animated: false)
    }
}

