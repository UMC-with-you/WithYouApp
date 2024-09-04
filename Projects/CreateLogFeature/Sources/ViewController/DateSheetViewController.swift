//
//  DateSheetViewController.swift
//  WithYou
//
//  Created by 김도경 on 4/20/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class DateSheetViewController: BaseViewController {
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = Locale(identifier: "ko_KR")
        return datePicker
    }()
    
    let doneButton =  WYButton("완료")
    
    var selectedDate = Date()
    
    var dateObservable : PublishSubject<Date> =  PublishSubject()
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
    }

    override func setUp() {
        view.addSubview(datePicker)
        view.addSubview(doneButton)
    }
    
    override func setLayout() {
        datePicker.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        doneButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    override func setFunc() {
        datePicker
            .rx
            .date
            .skip(1)
            .subscribe { [weak self] date in
                self?.doneButton.backgroundColor = WithYouAsset.mainColorDark.color
                self?.selectedDate = date
            }
            .disposed(by: disposeBag)
        
        doneButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.doneButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
    private func doneButtonTapped(){
        self.dateObservable.onNext(selectedDate)
        self.dateObservable.onCompleted()
        self.dismiss(animated: true)
    }
}
