//
//  WithUViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxGesture
import RxSwift
import RxCocoa
import UIKit
import SnapKit

class WithUViewController: UIViewController {
    
    var log : Log?
    var travelMembers = BehaviorSubject<[Traveler]>(value: [])
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 32)
//        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "DAY 2"
        label.textColor = UIColor(named: "MainColorDark")
        label.textAlignment = .center
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "오징어들의 오사카 여행"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 0.96, alpha: 1)
        return view
    }()
    
    let noticeView = NoticeView()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
//        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "오늘 하루 기록하기"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let rewindView: UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.backgroundColor = UIColor(red: 0.96, green: 0.76, blue: 0.69, alpha: 1)
        let systemImage = UIImage(systemName: "book.closed")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "오늘의 여행 Rewind"
        view.subLabel.text = "오늘 여행은 어떠셨나요?\n오늘 하루 느꼈던 감정과 기억을\n기록하고, 함께 여행한\n사람들과 나눌 수 있어요!"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        
        return view
    }()
    
    let chatView: UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.backgroundColor = UIColor(red: 0.6, green: 0.58, blue: 0.74, alpha: 1)
        let systemImage = UIImage(systemName: "ellipsis.bubble")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "오늘의 한마디"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "함께 여행한 with You에게\n오늘 하루를 마치며 하고 싶은\n말을 전해주세요! 하루에\n딱 하나의 메시지를 보낼 수\n있어요!"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let sideMenu = UIImageView(image: UIImage(named: "SideMenu"))
    
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        view.addSubview(dayLabel)
        view.addSubview(noticeView)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(underLine)
        view.addSubview(rewindView)
        view.addSubview(chatView)
        view.bringSubviewToFront(mainLabel)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: sideMenu), UIBarButtonItem(customView: ProfileView(size: .small, traveler: Traveler(id: 0, name: DataManager.shared.getUserName())))]
        
        noticeView.delegate = self
        
        //멤버 정보 가져오기
        LogService.shared.getAllMembers(logId: log!.id){ response in
            self.travelMembers.onNext(response)
            self.noticeView.members = response
        }
        
        setConstraints()
        setFunc()
        setInfo()
    }
    
    private func setInfo(){
        dayLabel.text = dateController.days(from: log!.startDate)
        mainLabel.text = log?.title
    }
    
    private func setFunc(){
        rewindView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                let nextVC = TravelRewindViewController()
                nextVC.log = self.log
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: bag)
        
        chatView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
               
            }
            .disposed(by: bag)
        
        sideMenu.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                self.openSideMenu()
            }
            .disposed(by: bag)
    }
    
    func openSideMenu(){
        let sideMenu = SideBarViewController()
        sideMenu.modalPresentationStyle = .overFullScreen
        //Log 전달
        sideMenu.bind(log: self.log!,members: try! self.travelMembers.value())
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        present(sideMenu,animated: false)
    }
    
    private func setConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(15)
        }
        
        underLine.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.top).offset(15)
            make.leading.equalTo(mainLabel.snp.leading)
        }
        
        noticeView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(25)
            make.leading.equalTo(mainLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().multipliedBy(0.5)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeView.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(15)
        }
        
        rewindView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(170)
        }

        chatView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(170)
        }
        sideMenu.snp.makeConstraints{
            $0.width.height.equalTo(30)
        }
    }
}

extension WithUViewController : NoticeViewDelegate {
    func addNotice() {
        let addNoticeView = AddNoticeViewController()
        addNoticeView.modalPresentationStyle = .overFullScreen
        
        addNoticeView.noticeAdder.subscribe(onNext: { noticeDic in
            LogService.shared.getAllMembers(logId: self.log!.id){ response in
                let memberId = response[0].id
                print(memberId)
                NoticeService.shared.createNotice(info: noticeDic, memberId: memberId, logId: self.log!.id){ response in
                    
                }
            }
            
        })
        .disposed(by: bag)
        
        present(addNoticeView, animated: false)
    }
}
