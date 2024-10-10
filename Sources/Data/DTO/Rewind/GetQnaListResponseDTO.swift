//
//  GetQnaListResponseDTO.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


typealias GetQnaListResponseDTO = [QnaResponseDTO]

struct QnaResponseDTO : Decodable {
    let id : Int
    let content : String
}

extension QnaResponseDTO {
    func toDomain() -> RewindQna{
        RewindQna(qnaId: 0, questionId: id, content: content, answer: "")
    }
}
