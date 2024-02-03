//
//  BottomSheetView.swift
//  WithYou
//
//  Created by 김도경 on 1/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit


class NewLogSheetView: UIViewController {
    let firstLine = TwoComponentLineView("새로운 Log 만들기", imageView: WYAddButton(.small))
    
    let separator = SeparatorView()
    
    let secondLine = TwoComponentLineView("다른 Log 들어가기", imageView: UIImageView(image: UIImage(named:"InIcon")))
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        textField.placeholder = "초대코드를 입력해주세요"
        textField.textAlignment = .center
        return textField
    }()
    
    let createButton = WYButton("여행 만들기")
    
    public var commander = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textField.delegate = self
        setUp()
        setConst()
    }
    
    private func setUp(){
        view.addSubview(firstLine)
        view.addSubview(separator)
        view.addSubview(secondLine)
        view.addSubview(textField)
        view.addSubview(createButton)
        
        firstLine.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toCreateLog(_ :))))
        firstLine.isUserInteractionEnabled = true
    }
    
    private func setConst(){
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
        createButton.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(7)
            $0.width.leading.equalTo(firstLine)
            $0.height.equalTo(40)
        }
    }
    
    //새 로그 생성
    @objc
    private func toCreateLog(_ gesture : UITapGestureRecognizer){
        dismiss(animated: true)
        self.commander.onCompleted()
    }
     
    //로그 참여 로직
    
    
}

extension NewLogSheetView : UITextFieldDelegate{
    
}

