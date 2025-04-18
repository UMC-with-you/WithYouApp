//
//  Router.swift
//  WithYou
//
//  Created by 김도경 on 2/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation


protocol BaseRouter : URLRequestConvertible {
    var baseURL : String { get }
    var method : HTTPMethod { get }
    var path : String { get }
    var parameter : RequestParams { get }
    var header : HeaderType { get }
    var multipart : MultipartFormData {get}
}

extension BaseRouter {
    public func asURLRequest() throws -> URLRequest {
        var url : URL
        var urlRequest : URLRequest
        
        if path == "" {
            // path가 공백인 경우 , appendingPathComponent를 사용하면 "/"가 하나 더 생기는 문제가 있음
            // 따로 ""인 경우로 나눠서 생성
            url = try String(baseURL+path).asURL()
            urlRequest = try URLRequest(url: url, method : method)
        } else {
            url = try baseURL.asURL()
            urlRequest = try URLRequest(url: url.appendingPathComponent(path), method : method)
        }
        urlRequest = self.makeHeaderForRequest(to: urlRequest)
        return try self.makePrameterForRequest(to: urlRequest, with: url)
    }
    
    private func makeHeaderForRequest(to request: URLRequest) -> URLRequest {
        var request = request
        switch header {
        case .withAuth :
            request.setValue(Constants.ApplicationJson, forHTTPHeaderField: Constants.ContentType)
            request.setValue("Bearer " + SecureDataManager.shared.getData(label: .accessToken), forHTTPHeaderField: Constants.Authorization)
            //request.setValue("1", forHTTPHeaderField: Constants.Authorization)
            return request
        case .basicHeader:
            request.setValue(Constants.ApplicationJson, forHTTPHeaderField: Constants.ContentType)
            return request
        case .multiPart:
            request.setValue("Bearer " + SecureDataManager.shared.getData(label: .accessToken), forHTTPHeaderField: Constants.Authorization)
            return request
        case .noHeader :
            return request
        case .onlyAuth:
            //request.setValue("application/json", forHTTPHeaderField: Constants.ContentType)
            request.setValue("Bearer " + SecureDataManager.shared.getData(label: .accessToken), forHTTPHeaderField: Constants.Authorization)
            return request
        }
    }
     
    private func makePrameterForRequest(to request: URLRequest, with url: URL) throws -> URLRequest {
        var request = request
        switch parameter {
        case .query(let parameters):
            let queryParams = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components : URLComponents?
            if path == "" {
                components = URLComponents(string: url.absoluteString)
            } else {
                components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            }
            components?.queryItems = queryParams
            request.url = components?.url
        case .body(let parameters):
            //request = JSONParameterEncoder.default.encode(parameters, into: request)
            let body = try JSONEncoder().encode(parameters)
            request.httpBody = body
        case .bodyFromDictionary(let parameter):
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
        case .none:
            break
        }
        return request
    }
}


extension BaseRouter {
    var baseURL: String {
        return Constants.baseURL
    }
    
    var header: HeaderType {
        return HeaderType.withAuth
    }
    
    var multipart: MultipartFormData {
        return MultipartFormData()
    }
}
