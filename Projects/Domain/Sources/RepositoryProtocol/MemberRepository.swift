//
//  MemberRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol MemberRepository {
    func changeName(name : String) -> Single<String>
    func changeProfilePic(image : Data) -> Single<String>
    func getMemberInfo() -> Single<Member>
}
