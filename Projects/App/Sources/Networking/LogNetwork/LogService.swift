//
//  LogService.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

struct ImageFile {
    let filename: String
    let data: Data
    let type: String
}

class LogService : BaseService {
    static let shared = LogService()
    private override init(){}
    
    //로그 추가
    public func addLog(log : Log, image : UIImage, _ completion: @escaping (LogIDResponse)-> ()){
        let router = LogRouter.addLog(log: log, image: image)
        AFManager.upload(multipartFormData: router.multipart, with: router).responseDecodable(of: APIContainer<LogIDResponse>.self){ response in
            switch response.result{
            case .success(let container):
                completion(container.result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //모든 여행 로그 조회
    public func getAllLogs(_ completion: @escaping ([Log])-> ()) {
        requestReturnsData([Log].self, router: LogRouter.getAllLog,completion: completion)
    }

    
    //로그 삭제
    public func deleteLog(logId : Int , _ completion: @escaping (LogIDResponse) -> ()){
        requestReturnsData(LogIDResponse.self, router: LogRouter.deleteLog(travelId: logId), completion: completion)
    }
    
    //로그 수정
    public func editLog(logId : Int,editRequest : EditLogRequest,image: UIImage, _ completion: @escaping (LogIDResponse) -> ()){
        let router = LogRouter.editLog(travelId: logId, editRequest: editRequest, image: image)
        AFManager.upload(multipartFormData: router.multipart, with: router).responseDecodable(of: APIContainer<LogIDResponse>.self){
            response in
            switch response.result {
            case .success(let container):
                completion(container.result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //로그 참가
    public func joinLog(invitationCode : String, _ completion: @escaping (LogJoinResponse) -> ()){
        requestReturnsData(LogJoinResponse.self, router: LogRouter.joinLog(inviteCode: invitationCode), completion: completion)
    }
    
    //로그 참여한 모든 멤버 불러오기
    public func getAllMembers(logId : Int, _ completion: @escaping ([Traveler]) -> ()){
        requestReturnsData([Traveler].self, router: LogRouter.getAllLogMemebers(travelId: logId), completion: completion)
    }
    
    //로그 초대 코드 가져오기
    public func getInviteCode(logId : Int , _ completion: @escaping (InviteCodeResponse) -> ()){
        requestReturnsData(InviteCodeResponse.self, router: LogRouter.getInviteCode(travelId: logId), completion: completion)
    }
    
    //로그 나가기
    public func leaveLog(travelId : Int, memberId: Int, _ completion: @escaping (LogJoinResponse)->()){
        requestReturnsData(LogJoinResponse.self, router: LogRouter.leaveLog(travelId: travelId, memberId: memberId), completion: completion)
    }
    
    func createBody(paramaeters: [String: Any], boundary: String, images: [ImageFile]?) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"

        for (key, value) in paramaeters {
          body.append(boundaryPrefix.data(using: .utf8)!)
          body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        // image를 첨부하지 않아도 작동할 수 있도록 if let을 통해 images 여부 확인
        // requst의 key값의 이름에 따라 name의 값을 변경
        if let images = images {
            for image in images {
              body.append(boundaryPrefix.data(using: .utf8)!)
              body.append("Content-Disposition: form-data; name=\"images[]\"; filename=\"\(image.filename)\"\r\n".data(using: .utf8)!)
              body.append("Content-Type: image/\(image.type)\r\n\r\n".data(using: .utf8)!)
              body.append(image.data)
              body.append("\r\n".data(using: .utf8)!)
          }
        }

        body.append(boundaryPrefix.data(using: .utf8)!)

        return body
    }
    
}



