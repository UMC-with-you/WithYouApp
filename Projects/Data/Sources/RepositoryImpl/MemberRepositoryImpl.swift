//
//  MemberRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Domain
import Foundation
import RxSwift

final public class DefaultMemberRepository : MemberRepository {
    
    let service = BaseService()
    
    public func changeName(name: String) -> Single<String> {
        let router = MemberRouter.changeName(name: name)
        return service.request(String.self, router: router)
    }
    
    public func changeProfilePic(image: Data) -> Single<Void> {
        let router = MemberRouter.changePic(image: image)
        return service.requestWithImage(String.self, router: router).map{ _ in () }
    }
    
    public func getMemberInfo() -> Single<Member> {
        let router = MemberRouter.getInfo
        return service.request(Member.self, router: router)
    }
    
    
}
