//
//  MemberUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol MemberUseCase {
    func changeName(name : String) -> Single<String>
    func changeProfilePic(image : Data) -> Single<Void>
    func getMemberInfo() -> Single<Member>
}

final public class DefaultMemberUseCase : MemberUseCase {
    
    let repository : MemberRepository
    
    public init(repository: MemberRepository) {
        self.repository = repository
    }
    
    public func changeName(name: String) -> Single<String> {
        repository.changeName(name: name)
    }
    
    public func changeProfilePic(image: Data) -> Single<Void> {
        repository.changeProfilePic(image: image)
    }
    
    public func getMemberInfo() -> Single<Member> {
        repository.getMemberInfo()
    }
    
    
}
