//
//  AddNoticeViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxGesture
import RxSwift
import SnapKit
import UIKit



class AddNoticeViewController: UIViewController {
    
    var noticeOption : NoticeOptions = .before
    
    //내용 담는 변수
    var noticeText = ""
    
    let popupView = {
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
    lazy var button = {
        let button = UIButton()
        button.menu = UIMenu(options: .singleSelection, children: self.options)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.titleLabel?.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
        button.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
        return button
    }()
    let dropDownImage = {
        let img = UIImageView(image: UIImage(named: "DownMark"))
        return img
    }()
    
    let label = {
        let label = UILabel()
        label.text = "NOTICE"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 17)
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
    
    //TextView
    let textViewPlaceHolder = "내용을 입력해주세요"
    let textView = {
        let tv = UITextView()
        tv.font = WithYouFontFamily.Pretendard.regular.font(size: 13)
        tv.layer.cornerRadius = 15
        tv.layer.borderWidth = 1
        tv.layer.borderColor = WithYouAsset.subColor.color.cgColor
        tv.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        tv.autocorrectionType = .no
        tv.spellCheckingType = .no
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
    
    let addButton = WYButton("추가하기")
    
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        
        setUp()
        setConst()
        setTextView()
        setGesture()
    }
    
    func setGesture(){
        closeButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.dismiss(animated: false)
            })
            .disposed(by: bag)
        
        addButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext:{ _ in
                self.addNotice()
            })
            .disposed(by: bag)
    }
    
    func setTextView(){
        textView.delegate = self
        textView.text = textViewPlaceHolder
        textView.textColor = WithYouAsset.subColor.color
    }
    
    func setUp(){
        view.addSubview(popupView)
        [button,dropDownImage].forEach{
            dropDownContainer.addSubview($0)
        }
        [dropDownContainer,label,closeButton,textView,addButton,characterCountLabel].forEach{
            popupView.addSubview($0)
        }
    }
    
    func setConst(){
        popupView.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.center.equalToSuperview()
        }
        
        dropDownContainer.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(label.snp.leading).offset(-35)
            $0.top.equalToSuperview().offset(15)
            $0.height.equalTo(30)
        }
        button.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        dropDownImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        label.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
            $0.height.equalTo(30)
        }
        closeButton.snp.makeConstraints{
            $0.width.height.equalTo(17)
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalTo(label.snp.centerY)
        }
        textView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(label.snp.bottom).offset(15)
            $0.bottom.equalTo(addButton.snp.top).offset(-15)
        }
        characterCountLabel.snp.makeConstraints{
            $0.bottom.equalTo(textView.snp.bottom).offset(-5)
            $0.trailing.equalTo(textView.snp.trailing).offset(-10)
        }
        addButton.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-15)
            $0.width.equalTo(textView.snp.width)
        }
    }
    
    func addNotice(){
        self.view.endEditing(true)
        // Notice 처리
        print(noticeText + noticeOption.text)
    }
}

extension AddNoticeViewController : UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 입력 시 테두리 색 변경
        textView.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
        
        // Placholder 변경
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.textColor = WithYouAsset.subColor.color
            textView.text = textViewPlaceHolder
        } else if textView.text == textViewPlaceHolder {
            textView.textColor = WithYouAsset.mainColorDark.color
            textView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 글자 수 제한
        if textView.text.count > 30 {
            textView.deleteBackward()
        }
        // 글자수 변경
        characterCountLabel.text = "\(textView.text.count)/30"
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = WithYouAsset.subColor.color.cgColor
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == textViewPlaceHolder{
            textView.text = textViewPlaceHolder
            textView.textColor = WithYouAsset.subColor.color
            
        } else {
            self.addButton.backgroundColor = WithYouAsset.mainColorDark.color
        }
        
        self.noticeText = textView.text
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.textView.resignFirstResponder()
        return true
    }
}
