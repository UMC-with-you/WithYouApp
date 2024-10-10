//
//  OnGoingTravelView.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import UIKit

public class OnGoingTravelView : BaseUIView {
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
    
    let backGround = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
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
    
    override public func initUI() {
        self.addSubview(dayLabel)
        self.addSubview(backGround)
        self.addSubview(noticeView)
        self.addSubview(mainLabel)
        self.addSubview(subLabel)
        self.addSubview(underLine)
        self.addSubview(rewindView)
        self.addSubview(chatView)
        self.bringSubviewToFront(mainLabel)
    }
    
    override public func initLayout() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
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
        
        backGround.snp.makeConstraints{
            $0.edges.equalTo(noticeView)
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
