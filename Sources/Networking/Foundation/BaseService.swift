//
//  BaseService.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation


class BaseService {
    
    let AFManager: Session = {
            var session = AF
            let configuration = URLSessionConfiguration.af.default
            let eventLogger = APIEventLogger()
            session = Session(configuration: configuration, eventMonitors: [eventLogger])
            return session
        }()

    func requestReturnsData<T: Codable>(_ dataType : T.Type, router : BaseRouter, completion : @escaping (T) -> Void ){
        AFManager.request(router).responseDecodable(of: APIContainer<T>.self){ response in
            switch response.result {
            case .success(let container):
                completion(container.result)
            case .failure(let error ):
                print(error)
            }
        }
    }
    
    func requestReturnsNoData(router : BaseRouter, completion : @escaping (Any) -> Void){
        AFManager.request(router).responseDecodable(of:APIContainer<[String:String]>.self){ reponse in
            
        }
    }
    
    func authRequest(router : BaseRouter, completion : @escaping (Any)-> Void){
        AFManager.request(router).responseDecodable(of: AuthModelResponse.self) { response in
            switch response.result {
            case .success(let tokens):
                completion(tokens)
            case .failure(let error):
                print(error)
            }
        }
    }
}



final class MyRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        //urlRequest.setValue("1", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
}
