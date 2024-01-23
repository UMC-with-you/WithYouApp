//
//  BeforeTripLogViewViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/16/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit

class BeforeTripLogViewViewController: UIViewController {
    //D-day
    let day = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 32)
        label.textColor = .black
        return label
    }()
    
    //Log title
    //아래 줄 생성 예정
    let logTitle = {
       let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 20)
        label.textColor = .black
        return label
    }()
    //Notice
    //Packing Together
    
    //Add package
    let package = UIView()
    
    let textField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.placeholder = "  짐 추가하기"
        textField.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        textField.backgroundColor = .systemGray5
        textField.textColor = WithYouAsset.subColor.color.withAlphaComponent(1.2)
        return textField
    }()
    
    let addPackageButton = WYAddButton(.small)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        setUp()
        setPackage()
        setConst()
        
        
        day.text = "D-20"
        logTitle.text = "오징어들의 오사카 여행"
        // Do any additional setup after loading the view.
    }
    
    private func setUp(){
        [day,logTitle,package,textField].forEach{
            view.addSubview($0)
        }
    }
    
    private func setConst(){
        day.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        logTitle.snp.makeConstraints{
            $0.leading.equalTo(day)
            $0.top.equalTo(day.snp.bottom).offset(20)
        }
        
        package.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            //추후 위의 뷰와 거리 계산
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        textField.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        addPackageButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setPackage(){
        package.addSubview(textField)
        package.addSubview(addPackageButton)
    }
}


extension BeforeTripLogViewViewController: UITextFieldDelegate{

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 텍스트 필드가 편집을 시작할 때 호출되는 메서드
        textField.layer.cornerRadius = 8.0 // 둥근 테두리 반지름 설정
        textField.layer.borderWidth = 1.0 // 테두리 두께 설정
        textField.layer.borderColor = UIColor(named: "MainColor")?.cgColor // 테두리 색상 설정
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 텍스트 필드의 편집이 종료될 때 호출되는 메서드
        print("End Editing")
    }
}
