//
//  MemberService.swift
//  WithYou
//
//  Created by 김도경 on 2/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

class MemberService : BaseService {
    static let shared = MemberService()
    override private init(){}
    
    public func changeName( name : String, _ completion : @escaping ()->Void){
        AFManager.request(MemberRouter.changeName(name: name))
            .validate(statusCode: 200..<300)
            .responseString{ response in
            switch response.result {
            case .success(let string):
                print(string)
                completion()
            case .failure(let error ):
                print(error)
            }
        }
    }
    
    public func changeImage(profilePicture : UIImage,_ completion : @escaping ()->Void){
        let router = MemberRouter.changePic(picture: profilePicture)
        AFManager.upload(multipartFormData: router.multipart, with: router)
            .validate(statusCode: 200..<300)
            .responseData{ data in
                print(data)
            }
    }
    
    public func getInfo(_ completion : @escaping (Member)->Void){
        AFManager.request(MemberRouter.getInfo).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    print(json)
                } catch {
                    print("errorMsg")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
