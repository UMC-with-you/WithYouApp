//
//  NoticeDataManager.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

class NoticeDataManager {
    
    private var noticeDataArray: [Notice] = []

    func getNoticeData() -> [Notice] {
        return noticeDataArray
    }
    
    func updateNoticeFromServer(travelId: Int, _ completion : @escaping ()->()) {
        NoticeService.shared.getAllNoticByLog(travelId: travelId){ response in
            
        }
    }
}
