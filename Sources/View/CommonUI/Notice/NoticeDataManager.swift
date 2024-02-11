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

    func makeNoticeData() {
        noticeDataArray = [
            //Notice(profileImage: UIImage(named: "person"), userName: "경주", noticeString: "유니버셜 스튜디오\n9:00AM OPEN!")
        ]
    }

    func getNoticeData() -> [Notice] {
        return noticeDataArray
    }
    
    func updateNoticeData() {
        //let notice = Notice(profileImage: UIImage(named: "person"), userName: "경주", noticeString: "유니버셜 스튜디오\n9:00AM OPEN!")
        //noticeDataArray.append(notice)
    }
}
