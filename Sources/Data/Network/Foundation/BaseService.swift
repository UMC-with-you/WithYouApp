//
//  BaseService.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

//protocol NetworkService {
//    func request<T: Decodable>(_ responseDTO : T.Type, router: BaseRouter) -> Single<T>
//}

public class BaseService {
    
    let AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        let eventLogger = APIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        return session
    }()
    
    public init(){}
    
    func request<T:Decodable>( _ responseDTO : T.Type, router: BaseRouter) -> Single<T> {
        return Single<T>.create{ single in
            self.AFManager.request(router).responseDecodable(of: APIContainer<T>.self) { response in
                switch response.result {
                case .success(let container):
                    single(.success(container.result))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
            }
        }
    }
    
    func requestWithImage<T:Decodable>(_ responseDTO : T.Type, router: BaseRouter) -> Single<T> {
        return Single<T>.create { single in
            self.AFManager.upload(multipartFormData: router.multipart, with: router).responseDecodable(of : APIContainer<T>.self) { response in
                switch response.result {
                case .success(let container):
                    single(.success(container.result))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
            }
        }
    }
    
    func uploadToS3(router: S3Router, image : Data) -> Single<Void> {
        return Single<Void>.create { single in
    }
            self.AFManager.upload(image, with: router)
                    switch response.result{
                .response { response in
                    case .success(_):
                        single(.success(()))
                    case .failure(let error):
                        single(.failure(error))
                }
                    }
            return Disposables.create()
        }
    }
        }
            return Disposables.create()
            }
                    single(.failure(error))
                }
                case .failure(let error):
                    single(.success(imageData))
                    guard let imageData = data else { return }
                case .success(let data):
                switch response.result {
            self.AFManager.request(router).response{ response in
        return Single<Data>.create { single in
    func downloadS3(router: S3Router) -> Single<Data>{
    
    
}



final class MyRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let urlRequest = urlRequest
        
        //urlRequest.setValue("1", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
}
