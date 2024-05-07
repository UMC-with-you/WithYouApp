//
//  CreateLogViewModel.swift
//  CleanWithYou
//
//  Created by 김도경 on 4/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CreateLogViewModel {
    
    var textFieldObservable = BehaviorRelay<String>(value: "")
    
    var isDataFilled = BehaviorRelay(value: false)
    
    var title : String = ""
    var fromDate : Date?
    var toDate : Date?
    var image : UIImage?
    
    public func checkData(){
        if !title.isEmpty &&
            fromDate != nil &&
            toDate != nil &&
            image != nil {
            isDataFilled.accept(true)
        }
    }
    
    // UIKIT 의존성을 없애고싶음... 고민해보자
    public func createLog(){
        if isDataFilled.value {
            let startDate = fromDate!
            let endDate = toDate!
            let image = image!
            let log = Log(id: 0,
                          title: title,
                          startDate: dateController.dateToStr(startDate),
                          endDate: dateController.dateToStr(endDate),
                          status: "",
                          imageUrl: "")
            LogService.shared.addLog(log: log, image: image) { LogIDResponse in
                print(LogIDResponse)
            }
        }
    }
}


