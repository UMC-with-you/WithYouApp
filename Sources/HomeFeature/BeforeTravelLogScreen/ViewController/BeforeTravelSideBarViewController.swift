//
//  BeforeTravelSideBarViewController.swift
//  HomeFeature
//
//  Created by 김도경 on 6/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//




import UIKit

public protocol BeforeTravelSideBarDelegate : AnyObject{
    func dissmissView()
    func leaveLog()
}

public class BeforeTravelSideBarViewController: BaseViewController {
    
    let sideView = {
        let sv = UIView()
        //sv.round(corners: [.topLeft,.bottomLeft], cornerRadius: 15)
        sv.layer.cornerRadius = 15
        sv.backgroundColor = .white
        sv.layer.masksToBounds = true
        return sv
    }()
    
    let closeButton = {
        let button = UIButton()
        let image = UIImage(named: "xmark")
        button.setImage(image , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let label = {
        let title = UILabel()
        title.font = WithYouFontFamily.Pretendard.medium.font(size: 20)
        title.textColor = UIColor.gray
        return title
    }()
    
    let memberListView = {
        
        let table = UITableView(frame: .zero, style: .plain)
        table.rowHeight = 50
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        table.separatorStyle = .none
        table.allowsSelection = false
        table.isScrollEnabled = false
        table.register(SideBarMemberCell.self, forCellReuseIdentifier: SideBarMemberCell.cellId)
        return table
    }()
    
    let inviteFriend = TwoComponentLineView("친구 초대하기", imageView: WYAddButton(.small))
    
    let leaveTravel = {
       let x = TwoComponentLineView("그룹 나가기", imageView: UIImageView(image: UIImage(named: "Out")))
        x.changeConst {
            x.label.textColor = UIColor.gray
        }
        return x
    }()
    
    // MARK: Property
    
    let viewModel : BeforeTravelSideBarViewModel
    
    weak public var coordinator : BeforeTravelSideBarDelegate?
    
    public init(viewModel : BeforeTravelSideBarViewModel){
        self.viewModel = viewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadTravelers()
        self.bindLog()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    public override func setFunc() {
        
        //참여자 목록 설정
        viewModel.travelerRelay
            .bind(to: memberListView.rx.items(cellIdentifier: SideBarMemberCell.cellId, cellType: SideBarMemberCell.self)){ index, item, cell in
                let lineView = TwoComponentLineView(item.name, imageView: ProfileView(size: .medium))
                lineView.label.textColor = UIColor.gray
                lineView.label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
                
                cell.bindView(lineView)
            }
            .disposed(by: disposeBag)
        
        //친구 초대하기
        inviteFriend.rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe{ (owner, _) in
                owner.popInviteView()
            }
            .disposed(by: disposeBag)
        
        //종료 버튼
        closeButton.rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (owner, _) in
                owner.coordinator?.dissmissView()
            }
            .disposed(by: disposeBag)
        
        //그룹 나가기
        leaveTravel.rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe{ (owner, _) in
                owner.leaveLog()
            }
            .disposed(by: disposeBag)
        
    }
    
    override public func setUpViewProperty() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
    }

    override public func setUp(){
        view.addSubview(sideView)
        
        [closeButton,label,memberListView,inviteFriend,leaveTravel].forEach{
            sideView.addSubview($0)
        }
    }
    
    override public func setLayout() {
        sideView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.trailing.equalToSuperview()
        }
        
        sideView.subviews.forEach{
            $0.snp.makeConstraints{ $0.leading.equalToSuperview().offset(20) }
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(32)
        }
        
        label.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(20)
        }
        
        memberListView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        inviteFriend.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
            $0.bottom.equalTo(leaveTravel.snp.top).offset(-20)
        }
        
        leaveTravel.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
}

extension BeforeTravelSideBarViewController {
    
    private func bindLog(){
        self.label.text = viewModel.log.title
    }
    
    private func leaveLog(){
        viewModel.leaveLog()
            .subscribe { [weak self] _ in
                self?.coordinator?.leaveLog()
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
    
    func popInviteView() {
        viewModel.loadInviteCode()
            .subscribe { [weak self] code in
                let popUp = InviteCodeViewController(inviteCode: code)
                popUp.modalPresentationStyle = .overFullScreen
                popUp.modalTransitionStyle = .crossDissolve
                self?.present(popUp, animated: true)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}
