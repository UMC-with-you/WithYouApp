//
//  APIManager.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation
import UIKit


// MARK: 네트워크 통신
class APIManager{
    
    public static let shared = APIManager()
    
    let baseUrl = "http://54.150.234.75:8080/api/v1"

    // GET METHOD
    func getData<T: Decodable>(urlEndPoint:String,
                             parameter: Parameters? = nil,
                               header : HTTPHeaders? = nil,
                               dataType : T.Type,
                               _ completion: @escaping (T) -> Void){
        
        let url = baseUrl + urlEndPoint
        
        print(url)
        
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseDecodable(of: T.self){ response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // POST METHOD
    func postData<T: Codable, R: Decodable>(urlEndPoint: String,
                                          parameter: APIParameters? = nil,
                                            header : HTTPHeaders? = nil,
                                          dataType : T.Type,
                                          responseType : R.Type,
                                          _ completion: @escaping (APIContainer<R>) -> Void){
        
        let url = baseUrl + urlEndPoint
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of : APIContainer<R>.self){ response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(let error ):
                    print(error)
                }
            }
    }
    
    
    // Get Image
    // 미완
    func getImage(_ completion: @escaping (Data) -> Void ){
        AF.request(baseUrl).responseData { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
 }


struct LogResponse : Codable {
    var id : Int
    
    private enum CodingKeys : String, CodingKey{
        case id = "travelId"
    }
}

struct InviteCodeResponse : Codable {
    var id : Int
    var invitationCode : String
    
    private enum CodingKeys : String, CodingKey{
        case id = "travelId"
        case invitationCode
    }
}

struct testModel : Codable{
    var message : String
    var code : String
    var isSuccess : Bool
    var result : [Log]
}

struct kakaoResponse : Codable {
    var accessToken : String
    var refreshToken : String
}

struct packingResponse : Codable {
    var packingItemId : Int
}
