//
//  CloudRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

enum CloudRouter {
    case addCloud(cloudModel : CloudRequest, images : [UIImage])
    case getCloud(travelId : Int, logId : Int)
}

extension CloudRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    var method: HTTPMethod {
        switch self {
        case .addCloud:
            return .post
        case .getCloud:
            return .get
        }
    }
    
    var path: String {
        switch self{
        case .addCloud:
            return "/cloud"
        case .getCloud(let travelId,_):
            return "/cloud/\(travelId)"
        }
    }
    
    var parameter: RequestParams {
        switch self {
        case .getCloud(_,let logId):
            return .query(["logId":logId])
        default:
            return .none
        }
    }
    
    var header: HeaderType{
        return .noHeader
    }
    
    var multipart: MultipartFormData{
        switch self{
        case .addCloud(let request , let images):
            let multiPart = MultipartFormData(boundary: "<calculated when request is sent>")
            
            let dic = [
                "date" : request.date,
                "travelId" : request.travelId
            ] as [String : Any]
            
            var text = "\(dic)"
            text = text.replacingOccurrences(of: "[", with: "{")
            text = text.replacingOccurrences(of: "]", with: "}")
            print(text)
            multiPart.append(text.data(using: .utf8)!, withName: "request", mimeType: "application/json")
            
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.1){
                    print(imageData)
                    multiPart.append(imageData, withName: "cloudImage", fileName: "image\(index).jpeg", mimeType: "image/jpeg")
                }
            }
            return multiPart
        default:
            return MultipartFormData()
        }
    }
}
