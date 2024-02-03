//
//  InvitePopUpViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

class InvitePopUpViewController: UIViewController {

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
        label.text = "NOTICE"
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
    
    let inviteCode = {
        let label = UILabel()
        // 서버에서 받아오기
        label.text = "NOTICE"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 24)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    let closeButton = {
        let button = UIButton()
        let image = UIImage(named: "xmark")
        button.setImage(image , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let sendButton = WYButton("초대장 보내기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        
        
        setUp()
        setConst()
    }
    
    private func setUp(){
        view.addSubview(popupView)
        
        [topTitle,mainTitle,closeButton,infoTitle,inviteCode,sendButton].forEach{
            popupView.addSubview($0)
        }
    }

    private func setConst(){
        popupView.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
    }

}
