//
//  MemberRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation
import UIKit


enum MemberRouter {
    case changeName(name:String)
    case changePic(picture : UIImage)
    case getInfo
}

extension MemberRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    var method: HTTPMethod {
        switch self {
        case .changeName, .changePic:
            return .patch
        case .getInfo:
            return .get
        }
    }
    
    var header: HeaderType{
        switch self{
        case .getInfo, .changeName:
            return .withAuth
        case .changePic:
            return .multiPart
        }
    }
    
    var path: String {
        switch self {
        case .changeName:
            return "/member/name"
        case .changePic:
            return "/member/image"
        case .getInfo :
            return "/member"
        }
    }
    
    var parameter: RequestParams {
        switch self {
        case .changeName(let name):
            return .body(["name": name])
        case .changePic, .getInfo:
            return .none
        }
    }
    

    var multipart: MultipartFormData{
        switch self {
        case .changePic(let image):
            let multiPart = MultipartFormData(boundary: "<calculated when request is sent>")
            if let imageData = image.jpegData(compressionQuality: 0.6){
                print(imageData)
                multiPart.append(imageData, withName: "image", fileName: "profilePicture.jpeg", mimeType: "image/jpeg")
            }
            return multiPart
        default:
            return MultipartFormData()
        }
    }
    
    
}
