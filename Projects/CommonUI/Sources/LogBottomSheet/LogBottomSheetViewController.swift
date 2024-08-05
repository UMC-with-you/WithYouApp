//
//  LogBottomSheetViewController.swift
//  CommonUI
//
//  Created by 김도경 on 5/30/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import RxGesture
import RxSwift
import SnapKit
import UIKit

public protocol LogBottomSheetDelegate {
    func createLog()
    func joinLog(invitationCode : String)
}

public class LogBottomSheetViewController : BaseViewController {
    
    let sheetView = LogBottomSheetView()
    
    var delegate : LogBottomSheetDelegate?
    
    public override func setLayout() {
        sheetView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    public override func setUpViewProperty() {
        view.backgroundColor = .white
    }
    
    public override func setUp() {
        view.addSubview(sheetView)
    }
    
    public override func setDelegate() {
        sheetView.textField.delegate = self
    }
    
    public override func setFunc(){
        //키보드 팝업시 화면 올라감
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        sheetView.firstLine
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                self?.toCreateLog()
            }
            .disposed(by: disposeBag)
        
        //로그 참여
        sheetView.joinButton
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                self?.joinLog()
            }
            .disposed(by: disposeBag)
    }
    
    //새 로그 생성
    private func toCreateLog(){
        //여기 Coordinator에게 위임하기
        self.delegate?.createLog()
        dismiss(animated: true)
    }
    
    //로그 코드로 참여하기
    private func joinLog(){
        if let text = sheetView.textField.text, text.count > 10 {
            self.delegate?.joinLog(invitationCode: text)
        } else {
            //Toast 메시지 띄우기
        }
    }
}


extension LogBottomSheetViewController : UITextFieldDelegate {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // 입력 시 테두리 색 변경
        sheetView.textField.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if text.count > 10{
                sheetView.joinButton.backgroundColor = WithYouAsset.mainColorDark.color
            } else {
                sheetView.joinButton.backgroundColor = WithYouAsset.subColor.color
            }
            return true
        } else {
            return false
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
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

