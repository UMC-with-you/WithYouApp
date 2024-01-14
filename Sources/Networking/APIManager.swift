//
//  APIManager.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import Alamofire


class APIManager{
    public static let shared = APIManager()
    
    
    // API GET 
    func getData<T: Decodable>(_ url: URL, parameter: Parameters, dataType : T, _ completion: @escaping (T) -> Void){
        AF.request(url,method: .get,parameters: parameter)
            .responseDecodable(of: T.self){ response in
                switch response.result{
                case .success(let result):
                    completion(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
 }
