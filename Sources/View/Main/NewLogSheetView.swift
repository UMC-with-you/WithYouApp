//
//  BottomSheetView.swift
//  WithYou
//
//  Created by 김도경 on 1/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import UIKit

class NewLogSheetView: UIViewController {
    let firstLine = TwoComponentLineView("새로운 Log 만들기", imageView: WYAddButton(.small))
    
    let separator = SeparatorView()
    
    let secondLine = TwoComponentLineView("다른 Log 들어가기", imageView: UIImageView(image: UIImage(named:"InIcon")))
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = WithYouAsset.subColor.color.cgColor
        textField.layer.masksToBounds = true
        textField.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        textField.placeholder = "초대코드를 입력해주세요"
        textField.textAlignment = .center
        return textField
    }()
    
    let createButton = WYButton("다른 Log 들어가기")
    
    public var commander = PublishRelay<Bool>()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        setConst()
        setFunc()
        
    }
    
    private func setUp(){
        view.addSubview(firstLine)
        view.addSubview(separator)
        view.addSubview(secondLine)
        view.addSubview(textField)
        view.addSubview(createButton)
        
        textField.delegate = self
    }
    
    private func setFunc(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        firstLine.rx.tapGesture()
            .when(.recognized)
            .subscribe({ _ in
                self.toCreateLog()
            })
            .disposed(by: bag)
        
        createButton.rx.tapGesture()
            .when(.recognized)
            .subscribe({ _ in
                self.joinLog()
            })
            .disposed(by: bag)
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
    private func toCreateLog(){
        dismiss(animated: true)
        self.commander.accept(true)
    }
     
    //로그 참여 로직
    private func joinLog(){
        if let text = self.textField.text, text.count > 10 {
            LogService.shared.joinLog(invitationCode: text){ _ in
                self.view.endEditing(true)
                let alert = UIAlertController(title: "Travel 참여 완료", message: "성공적으로 참여가 완료되었습니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}

extension NewLogSheetView : UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 입력 시 테두리 색 변경
        self.textField.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if text.count > 10{
                createButton.backgroundColor = WithYouAsset.mainColorDark.color
            } else {
                createButton.backgroundColor = WithYouAsset.subColor.color
            }
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = WithYouAsset.subColor.color.cgColor
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyBoardHeight = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyBoardHeight.cgRectValue.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
