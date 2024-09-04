//
//  InviteCodeViewController.swift
//  CreateLogFeature
//
//  Created by 김도경 on 6/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import UIKit

public class InviteCodeViewController : BaseViewController {
    
    // MARK: UIComponents
    let popupView = {
        let view = UIView()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let topTitle = {
        let label = UILabel()
        label.text = "친구 초대"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 17)
        label.textColor = WithYouAsset.mainColorDark.color
        
        return label
    }()
    
    let mainTitle =  {
        let label = UILabel()
        // Travel Log로 가져오기
        label.text = "선릉역의 코딩 파티"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    let infoTitle = {
        let label = UILabel()
        label.text = "Travel Log 초대 코드"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.subColor.color
        return label
    }()
    
    let inviteCodeLabel = {
        let label = UILabel()
        // 서버에서 받아오기
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 24)
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let closeButton = {
        let button = UIButton()
        let image = UIImage(named: "xmark")
        button.setImage(image , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let sendButton = {
        let button = WYButton("초대장 보내기")
        button.backgroundColor = WithYouAsset.mainColorDark.color
        return button
    }()
    
    // MARK: Property
    let inviteCode : String
    
    public init(inviteCode: String) {
        self.inviteCode = inviteCode
        self.inviteCodeLabel.text = inviteCode
        super.init()
    }
    
    override public func setFunc() {
        closeButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner,_) in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        sendButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner,_) in
                let activityViewController = UIActivityViewController(activityItems: [owner.inviteCode], applicationActivities: nil)
                owner.present(activityViewController,animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override public func setUpViewProperty() {
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
    }
    
    override public func setUp() {
        view.addSubview(popupView)
        
        [topTitle,mainTitle,closeButton,infoTitle,inviteCodeLabel,sendButton].forEach{
            popupView.addSubview($0)
        }
    }
    
    override public func setLayout() {
        popupView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.35)
        }
        
        topTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
        }
        
        closeButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(15)
        }
        
        mainTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topTitle.snp.bottom).offset(30)
        }
        
        infoTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
        }
        
        inviteCodeLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        sendButton.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
}
