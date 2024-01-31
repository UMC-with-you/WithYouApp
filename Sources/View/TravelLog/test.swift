//
//  test.swift
//  WithYou
//
//  Created by 배수호 on 1/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import UIKit

class test {
    
    let url:String =  "http://54.150.234.75:8080/api/v1/travels"
    let parameters  = [
        "title" : "stirng",
        "startDate" : "2024-01-31",
        "endDate" : "2024-01-31",
        "url" : "string"
    ]
    
    let header: HTTPHeaders = [
        "Authorization" : "1"
    ]
    
    public func testAPI() {
        AF.request(url, method: .post, parameters: parameters, headers: header).responseDecodable(of: testMode.self) { response in
            switch response.result {
            case .success(let data):
                print("성공")
                print(response.data ?? "empty")
            case .failure(let error) :
                print("실패")
                print(response.error ?? "empty")
            }
        }
    }
}
