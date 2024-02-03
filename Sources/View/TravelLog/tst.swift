//
//  testAPI.swift
//  TestAlamore
//
//  Created by 정의찬 on 1/31/24.
//

import Foundation
import Alamofire

class TestAPI {
    let url = "http://54.150.234.75:8080/api/v1/travels"
    let parameters = [
        "title": "String",
        "startDate": "2024-01-31",
        "endDate": "2024-01-31",
        "url": "string"
    ]
    
    let headers: HTTPHeaders = [
        "Authorization": "1",
    ]
    
    func testApi() {
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: TestModel.self) { response in
            switch response.result {
            case .success(let data):
                print(data.message)
                print(data.result)
                print(data.code)
                print(data.isSuccess)
            case.failure(let error):
                print(error)
            }
        }
    }
}

struct Test : Codable {
    var isSuccess : Bool
    var code : String
    var message : String
    var result : packing
    
    
}
struct packing : Codable{
    var packingItemId : Int
}

struct TestModel : Codable{
    var message : String
    var result : id
    var code : String
    var isSuccess : Bool
}

struct id : Codable {
    var travelId : Double
}
    
