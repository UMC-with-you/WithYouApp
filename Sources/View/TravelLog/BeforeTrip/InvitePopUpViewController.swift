//
//  InvitePopUpViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import RxSwift
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
        label.text = "선릉역의 코딩 파티"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    let infoTitle = {
        let label = UILabel()
        label.text = "Travel Log 초대 코드"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.mainColor.color
        return label
    }()
    
    let inviteCode = {
        let label = UILabel()
        // 서버에서 받아오기
        label.text = "gfcxhkggiyugyu"
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
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        
        var travelId = 3
        
        let url = "http://54.150.234.75:8080/api/v1/\(travelId)/invitation_code"
        
        let header : HTTPHeaders = [
            "Authorization" : "1"
        ]
        
        /*
        AF.request(url, method: .get, headers: header).responseDecodable(of: APIContainer<InviteCodeResponse>.self){ response in
            switch response.result{
            case .success(let data):
                self.inviteCode.text = data.result.invitationCode
            case .failure(let error):
                print(error)
            }
        }
         */
        
        setUp()
        setConst()
        setFunc()
    }
    
    private func setFunc(){
        closeButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.dismiss(animated: false)
            })
            .disposed(by: bag)
    }
    
    private func setUp(){
        view.addSubview(popupView)
        
        [topTitle,mainTitle,closeButton,infoTitle,inviteCode,sendButton].forEach{
            popupView.addSubview($0)
        }
    }

    private func setConst(){
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
        
        inviteCode.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
        }
        
        sendButton.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }

}
