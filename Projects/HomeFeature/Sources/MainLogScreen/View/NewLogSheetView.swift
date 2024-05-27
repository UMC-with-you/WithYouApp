//
//  NewLogSheetView.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import UIKit

class NewLogSheetView: BaseUIView {
    let firstLine = TwoComponentLineView("새로운 Log 만들기", imageView: WYAddButton(.small))
    
    let separator = SeparatorView()
    
    let secondLine = TwoComponentLineView("다른 Log 들어가기", imageView: UIImageView(image: UIImage(named:"InIcon")))
    
    let textField: WYTextField = {
        let textField = WYTextField()
        textField.placeholder = "초대코드를 입력해주세요"
        textField.textAlignment = .center
        return textField
    }()
    
    let joinButton = WYButton("다른 Log 들어가기")
    
    override func initUI() {
        self.addSubview(firstLine)
        self.addSubview(separator)
        self.addSubview(secondLine)
        self.addSubview(textField)
        self.addSubview(joinButton)
    }

    override func initLayout(){
        firstLine.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        separator.snp.makeConstraints{
            $0.top.equalTo(firstLine.snp.bottom)
            $0.height.equalTo(0.3)
            $0.leading.width.equalTo(firstLine)
        }
        secondLine.snp.makeConstraints{
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.width.height.equalTo(firstLine)
        }
        textField.snp.makeConstraints{
            $0.top.equalTo(secondLine.snp.bottom).offset(5)
            $0.width.leading.equalTo(firstLine)
            $0.height.equalTo(45)
        }
        joinButton.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(7)
            $0.width.leading.equalTo(firstLine)
            $0.height.equalTo(40)
        }
    }
}
