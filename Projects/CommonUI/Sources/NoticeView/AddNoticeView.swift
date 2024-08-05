//
//  AddNoticeView.swift
//  CommonUI
//
//  Created by 김도경 on 6/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Domain
import Foundation
import UIKit

public class AddNoticeView : BaseUIView {
    
    var noticeOption : NoticeOptions = .before
    
    let viewContainer = {
        let view = UIView()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        return view
    }()
    
    var options : [UIAction] {
        let before = UIAction(title: NoticeOptions.before.text) { [unowned self] _ in
            self.noticeOption = .before
        }

        let ing = UIAction(title: NoticeOptions.ing.text) { [unowned self] _ in
            self.noticeOption = .ing
        }
        
        let always = UIAction(title: NoticeOptions.always.text) { [unowned self] _ in
            self.noticeOption = .always
        }
        
        return [before,ing,always]
    }
    
    //옵션 버튼
    let dropDownContainer = {
       let con = UIView()
        con.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
        con.layer.borderWidth = 1
        con.layer.cornerRadius = 15
        return con
    }()
    
    public lazy var button = {
        var config = UIButton.Configuration.plain()
        config.indicator = .none
        config.contentInsets = .init(top: 7, leading: 5, bottom: 7, trailing: 5)
        
        config.image = WithYouAsset.downMark.image
        config.imagePlacement = .trailing
        config.imagePadding = 3
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
            outgoing.foregroundColor = WithYouAsset.mainColorDark.color
            return outgoing
        })
        
        let button = UIButton(configuration: config)
        
        let menu = UIMenu(options: .singleSelection, children: self.options)
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        
//        button.titleLabel?.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
//        button.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
//        //button.setImage(WithYouAsset.downMark.image, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
        
        return button
    }()
    
    let dropDownImage = {
        let img = UIImageView(image: WithYouAsset.downMark.image)
        return img
    }()
    
    let label = {
        let label = UILabel()
        label.text = "NOTICE"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 17)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    public let closeButton = {
        let button = UIButton()
        let image = WithYouAsset.xmark.image
        button.setImage(image , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    //TextView
    let textViewPlaceHolder = "내용을 입력해주세요"
    public let textView = {
        let tv = UITextView()
        tv.font = WithYouFontFamily.Pretendard.regular.font(size: 13)
        tv.layer.cornerRadius = 15
        tv.layer.borderWidth = 1
        tv.layer.borderColor = WithYouAsset.subColor.color.cgColor
        tv.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        tv.autocorrectionType = .no
        tv.spellCheckingType = .no
        tv.text = "내용을 입력해주세요"
        tv.textColor = WithYouAsset.subColor.color
        return tv
    }()
    let characterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/30"
        label.textColor = WithYouAsset.mainColorDark.color
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
        label.textAlignment = .right
        return label
    }()
    
    public let createButton = WYButton("추가하기")
    
    public func setTextFieldForReuse(){
        self.textView.text = ""
        characterCountLabel.text = "0/30"
        self.endEditing(true)
    }
    
    public override func initUI() {
        self.backgroundColor = .systemGray.withAlphaComponent(0.4)
        self.addSubview(viewContainer)
        
        self.textView.delegate = self
        
        [dropDownContainer,label,closeButton,textView,createButton,characterCountLabel,button].forEach{
            viewContainer.addSubview($0)
        }
    }
    
    public override func initLayout() {
        
        viewContainer.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.center.equalToSuperview()
        }
        
        label.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
            $0.height.equalTo(30)
        }
        
//        dropDownContainer.snp.makeConstraints{
//            $0.centerY.equalTo(label)
//            $0.leading.equalToSuperview().offset(15)
//            $0.trailing.equalTo(label.snp.leading).offset(-35)
//            $0.height.equalTo(30)
//        }
        
        button.snp.makeConstraints{
            $0.width.equalTo(90)
            $0.centerY.equalTo(label)
            $0.height.equalTo(28)
            $0.leading.equalToSuperview().offset(15)
        }
        
//        dropDownImage.snp.makeConstraints{
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview().offset(-8)
//        }
        
        closeButton.snp.makeConstraints{
            $0.width.height.equalTo(17)
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalTo(label.snp.centerY)
        }
        
        textView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalTo(createButton.snp.top).offset(-15)
        }
    
        characterCountLabel.snp.makeConstraints{
            $0.bottom.equalTo(textView.snp.bottom).offset(-5)
            $0.trailing.equalTo(textView.snp.trailing).offset(-10)
        }
        
        createButton.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.equalTo(textView.snp.width)
        }
    }
}

extension AddNoticeView : UITextViewDelegate {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        // 입력 시 테두리 색 변경
        textView.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
        
        // Placholder 변경
        if textView.text == textViewPlaceHolder {
            textView.textColor = WithYouAsset.mainColorDark.color
            textView.text = ""
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        // 글자 수 제한
        if textView.text.count > 30 {
            textView.deleteBackward()
        } else if textView.text.count > 0 {
            self.createButton.backgroundColor = WithYouAsset.mainColorDark.color
        } else if textView.text.count == 0 {
            self.createButton.backgroundColor = WithYouAsset.subColor.color
        }
        // 글자수 변경
        characterCountLabel.text = "\(textView.text.count)/30"
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = WithYouAsset.subColor.color.cgColor
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == textViewPlaceHolder{
            textView.text = textViewPlaceHolder
            textView.textColor = WithYouAsset.subColor.color
            createButton.backgroundColor = WithYouAsset.subColor.color
        }
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.textView.resignFirstResponder()
        return true
    }
}
