//
//  SideBarViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SideBarViewController: UIViewController {
    
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
    
    //MARK: Edit required
    let label = {
        let title = UILabel()
        //로그에서 가져와야함
        title.text = "오징어들의 오사카 여행"
        title.font = WithYouFontFamily.Pretendard.medium.font(size: 20)
        title.textColor = UIColor.gray
        return title
    }()
    
    let memberListView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width * 0.8 - 15
        layout.itemSize.height = 40
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 0)
        let list = UICollectionView(frame: .zero, collectionViewLayout: layout)
        list.register(SideBarMemeberListCell.self, forCellWithReuseIdentifier: SideBarMemeberListCell.cellId)
        return list
    }()
    
    let inviteFriend = TwoComponentLineView("친구 초대하기", imageView: WYAddButton(.small))
    
    
    let leaveTravel = {
       let x = TwoComponentLineView("그룹 나가기", imageView: UIImageView(image: UIImage(named: "Out")))
        x.changeConst {
            x.label.textColor = UIColor.gray
        }
        return x
    }()
    
    var members = BehaviorSubject<[Traveler]>(value: [
        Traveler(id: 0, name: "박우주", profilePicture: "xmark"),
        Traveler(id: 1, name: "우박주", profilePicture: "checkbox"),
        Traveler(id: 2, name: "주박우", profilePicture: "DownMark"),
        Traveler(id: 3, name: "우우우", profilePicture: "HomeIcon")
    ]
    )
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        
        setUp()
        setConst()
        setFunction()
        
        
       
       // members.onNext(dummyTravler)
    }
    
    private func setFunction(){
        //참여자 목록 설정
        members
            .bind(to: memberListView.rx.items(cellIdentifier: SideBarMemeberListCell.cellId, cellType: SideBarMemeberListCell.self)){ index, item, cell in
                let line = TwoComponentLineView(item.name, imageName: item.profilePicture)
                line.changeConst {
                    line.label.textColor = UIColor.gray
                    line.label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)

                }
                cell.bindView(line)
        }
            .disposed(by: bag)
        
        //친구 초대하기
        inviteFriend.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("Check")
                self.popInviteView()
            })
            .disposed(by: bag)
        
        //종료 버튼
        closeButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.dismissSideBar()
            })
            .disposed(by: bag)
        
        //그룹 나가기 설정 필요
        
    }
    
    private func setUp(){
        view.addSubview(sideView)
        
        [closeButton,label,memberListView,inviteFriend,leaveTravel].forEach{
            sideView.addSubview($0)
        }
    }
    
    private func setConst(){
        sideView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
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
            $0.top.equalTo(closeButton.snp.bottom).offset(20)
        }
        
        memberListView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        inviteFriend.snp.makeConstraints{
            $0.bottom.equalTo(leaveTravel.snp.top).offset(-50)
        }
        
        leaveTravel.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
    
    func dismissSideBar(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
    }
    
    func popInviteView(){
        let pv = InvitePopUpViewController()
        pv.modalPresentationStyle = .overFullScreen
        present(pv,animated: false)
    }
}
