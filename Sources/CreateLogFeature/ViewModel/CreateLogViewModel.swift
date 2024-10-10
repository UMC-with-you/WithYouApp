//
//  CreateLogViewModel.swift
//  CleanWithYou
//
//  Created by 김도경 on 4/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


public final class CreateLogViewModel {
    
    let logUseCase : LogUseCase
    
    var textFieldObservable = BehaviorRelay<String>(value: "")
    
    var isDataFilled = BehaviorRelay(value: false)
    
    var title : String = ""
    var fromDate : Date?
    var toDate : Date?
    var image : Data?
    
    public init(logUseCase : LogUseCase){
        self.logUseCase = logUseCase
    }
    
    public func checkData(){
        if !title.isEmpty &&
            fromDate != nil &&
            toDate != nil &&
            image != nil {
            isDataFilled.accept(true)
        }
    }
    
    public func createLog(){
        if isDataFilled.value {
            let startDate = fromDate!
            let endDate = toDate!
            let image = image!
            logUseCase.addLog(title: title,
                              startDate: startDate.toString(),
                              endDate: startDate.toString(),
                              image: image)
            .subscribe { _ in
                print("Create Succeed")
            } onFailure: { error in
                print("Error")
            }.dispose()

        }
    }
}
