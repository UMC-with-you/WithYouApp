//
//  GetNoticeResponseDTO.swift
//  Data
//
//  Created by 김도경 on 5/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import Foundation

public struct GetNoticeResponseDTO : Decodable {
    public let noticeDTOs : [NoticeDTO]
}

public struct NoticeDTO : Decodable {
    public let noticeId : Int
    public let url : String?
    public let name : String
    public let content : String
    public let checkNum : Int
}

extension GetNoticeResponseDTO {
    func toDomain(day: Int) -> [Notice] {
        var notices = [Notice]()
        for dto in noticeDTOs {
            notices.append(Notice(noticeID: dto.noticeId,
                                  profileImage: dto.url ?? "",
                                  state: .always,
                                  userName: dto.name,
                                  noticeContent: dto.content,
                                  checkNum: dto.checkNum,
                                 didUserChecked: false))
        }
        
        return notices
    }
}
