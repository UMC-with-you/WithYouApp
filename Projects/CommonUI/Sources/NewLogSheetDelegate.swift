//
//  NewLogSheetDelegate.swift
//  CommonUI
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

// MARK: Log 생성 BottomSheet 기능을 위한 Delegate
public protocol NewLogSheetDelegate {
    func showCreateLogScreen()
    func joinLog(invitationCode : String)
}
