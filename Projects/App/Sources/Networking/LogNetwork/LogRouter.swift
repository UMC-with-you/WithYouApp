//
//  LogRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation
import Domain
import UIKit

enum LogRouter  {
    case getAllLog
    case addLog(log: Log,image : UIImage)
    case deleteLog(travelId : Int)
    case editLog(travelId : Int, editRequest : EditLogRequest, image: UIImage)
    case joinLog(inviteCode : String)
    case getAllLogMemebers(travelId : Int)
    case getInviteCode(travelId : Int)
    case leaveLog(travelId : Int, memberId : Int)
}

extension LogRouter : BaseRouter {
    var baseURL: String {
        return Constants.baseURL + "/travels"
    }
    
    var method: HTTPMethod {
        switch self{
        case .getAllLog, .getInviteCode, .getAllLogMemebers :
            return .get
        case .addLog : return .post
        case .deleteLog : return .delete
        case .editLog, .joinLog , .leaveLog: return .patch
        }
    }
    
    var path: String {
        switch self{
        case .deleteLog(let travelId), .editLog(let travelId,_,_) :
            return "/\(travelId)"
        case .joinLog :
            return "/members"
        case .getAllLogMemebers(let travelId) :
            return "/\(travelId)/members"
        case .getInviteCode(let travelId):
            return "\(travelId)/invitation_code"
        case .leaveLog(let travelId, let memberId):
            return "\(travelId)/members/\(memberId)"
        default :
            return ""
        }
    }
    
    var parameter: RequestParams {
        switch self{
        case .getAllLog:
            return .query(["localDate" : dateController.currentDateToSendServer()])
        case .joinLog(let code):
            return .body(["invitationCode" : code])
        default:
            return .none
        }
    }
    
    var header: HeaderType {
        switch self{
        case .addLog,.editLog:
            return .multiPart
        default:
            return .withAuth
        }
    }
    
    var multipart: MultipartFormData{
        switch self{
        case .addLog(let log, let image):
            let multiPart = MultipartFormData(boundary:"<calculated when request is sent>")
            let LogRequesst = log.asLogRequest()
            
            var text = "\(LogRequesst)"
            text = text.replacingOccurrences(of: "[", with: "{")
            text = text.replacingOccurrences(of: "]", with: "}")
            if let imageData = image.jpegData(compressionQuality: 0.5){
                multiPart.append(imageData, withName: "bannerImage", fileName: "LogBannerImage.jpeg", mimeType: "image/jpeg")
            }
            
            multiPart.append(text.data(using: .utf8)!, withName: "request", mimeType: "application/json")
            
            return multiPart
            
        case .editLog(_,let editRequest, let image):
            let multiPart = MultipartFormData(boundary:"<calculated when request is sent>")
            
            var text = "\(editRequest.toDictionary())"
            text = text.replacingOccurrences(of: "[", with: "{")
            text = text.replacingOccurrences(of: "]", with: "}")
            print(text.data(using: .utf8)!)
            if let imageData = image.jpegData(compressionQuality: 0.5){
                multiPart.append(imageData, withName: "bannerImage", fileName: "LogBannerImage2.jpeg", mimeType: "image/jpeg")
            }
            
            multiPart.append(text.data(using: .utf8)!, withName: "request", mimeType: "application/json")
            
            return multiPart
        default:
            return MultipartFormData()
        }
    }
}
