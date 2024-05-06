//
//  MemberRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift
import UIKit

public protocol MemberRepository {
    func changeName(name : String) -> Single<Void>
    func changeProfilePic(image : UIImage) -> Single<Void>
    func getMemberInfo() -> Single<Member>
}
