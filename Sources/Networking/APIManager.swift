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


class APIManager{
    public static let shared = APIManager()
    
    let url = "http://54.150.234.75:8080/"

    
    // API GET
    func getData<T: Decodable>(parameter: Parameters, dataType : T.Type, _ completion: @escaping (T) -> Void){
        AF.request(url ,method: .get,parameters: parameter)
            .responseDecodable(of: T.self){ response in
                switch response.result{
                case .success(let result):
                    completion(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // Get Image
    func getImage(_ url : URL, _ completion: @escaping (Data) -> Void ){
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
 }



