//
//  LogRouter.swift
//  Data
//
//  Created by 김도경 on 5/10/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Domain
import Foundation

public enum LogRouter  {
    case getAllLog
    case addLog(logDTO: AddLogRequestDTO, image : Data?)
    case deleteLog(travelId : Int)
    case editLog(travelId : Int, editRequest : AddLogRequestDTO, image: Data?)
    case joinLog(inviteCodeDTO : JoinLogRequestDTO)
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
            
        case .editLog, .joinLog, .leaveLog: return .patch
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
            return .query(["localDate" : "dateController.currentDateToSendServer()"])
            
        case .joinLog(let dto):
            return .body(dto)
            
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
        case .addLog(let logDTO, let image):
            let multiPart = MultipartFormData(boundary:"<calculated when request is sent>")
            
            if let requestData = try? JSONEncoder().encode(logDTO) {
                multiPart.append(requestData, withName: "request", mimeType: "application/json")
            }

            if let imageData = image {
                multiPart.append(imageData, withName: "bannerImage", fileName: "LogBannerImage.jpeg", mimeType: "image/jpeg")
            }
            
            return multiPart
            
        case .editLog(_,let editRequest, let image):
            let multiPart = MultipartFormData(boundary:"<calculated when request is sent>")
            
            if let requestData = try? JSONEncoder().encode(editRequest) {
                multiPart.append(requestData, withName: "request", mimeType: "application/json")
            }
            if let imageData = image {
                multiPart.append(imageData, withName: "bannerImage", fileName: "LogBannerImage2.jpeg", mimeType: "image/jpeg")
            }
            
            return multiPart
            
        default:
            return MultipartFormData()
        }
    }
}
