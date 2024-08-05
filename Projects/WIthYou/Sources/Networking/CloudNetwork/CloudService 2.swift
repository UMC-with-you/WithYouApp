//
//  CloudService.swift
//  WithYou
//
//  Created by 김도경 on 2/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit


class CloudService : BaseService {
    static let shared = CloudService()
    override private init(){}
    
    func addCloud(cloudModel : CloudRequest, images: [UIImage],_ completion : @escaping (String)->Void){
        let router = CloudRouter.addCloud(cloudModel: cloudModel, images: images)
        multipartRequest(String.self, router: router, completion: completion)
    }
    
    func getCloud(travelId : Int, logId : Int, _ completion : @escaping ([CloudResponse])->Void){
        requestReturnsData([CloudResponse].self, router: CloudRouter.getCloud(travelId: travelId, logId: logId), completion: completion)
    }
}
