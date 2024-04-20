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
    
    var title : String = ""
    var fromDate : Date?
    var toDate : Date?
    var image : UIImage?
    
    let titleLength : Signal<String>
    
    /// 1. 제목
    /// 2. 날짜
    /// 3. 사진
    /// 4. 생성
    ///
    init(){
        let textFieldShare = textFieldObservable.share()
        
        titleLength = textFieldShare
            .map{ $0.count }
            .map{ textCount in
                return "\(textCount > 20 ? 20 : textCount)/20"
            }
            .asSignal(onErrorJustReturn: "")
    }
    
    // UIKIT 의존성을 없애고싶음... 고민해보자
    public func createLog(_ log : Log, image : UIImage){
        LogService.shared.addLog(log: log, image: image) { LogIDResponse in
            print(LogIDResponse)
        }
    }
}


