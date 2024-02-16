//
//  PostService.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class PostService : BaseService {
    static let shared = PostService()
    override private init(){}
    
    //모든 포스트 조회
    func getAllPost(travelId : Int, _ completion: @escaping ([Post])-> Void){
        requestReturnsData([Post].self, router: PostRouter.getAllPost(travelId: travelId), completion: completion)
    }
    
    //포스트 수정
    func addPost( travelId : Int, newPost : NewPostRequest, _ completion: @escaping (PostIdResponse)-> Void){
        requestReturnsData(PostIdResponse.self.self, router: PostRouter.addPost(travelId: travelId , newPost: newPost), completion: completion)
    }
    
    //포스트 단건 조회 보류
    /*
    func getOnePost( _ completion: @escaping (Any)-> Void){
        requestReturnsData(<#T##dataType: (Decodable & Encodable).Protocol##(Decodable & Encodable).Protocol#>, router: <#T##BaseRouter#>, completion: <#T##(Any) -> Void#>)
    }
     */
    
    //게시글 스크랩
    func scrapPost(postId: Int,_ completion: @escaping (PostIdResponse)-> Void){
        requestReturnsData(PostIdResponse.self, router: PostRouter.scrapPost(postId: postId), completion: completion)
    }
    
    //게시글 삭제
    func deletePost(postId: Int, _ completion: @escaping (PostIdResponse)-> Void){
        requestReturnsData(PostIdResponse.self, router: PostRouter.deletePost(postId: postId), completion: completion)
    }
    
    //게시글 수정
    func editPost(postId: Int, editContent: EditPostRequest, _ completion: @escaping (PostIdResponse)-> Void){
        requestReturnsData(PostIdResponse.self, router: PostRouter.editPost(postId: postId, editContent: editContent), completion: completion)
    }
    
    //스크랩 게시글 모두 조회
    func getScrapedPost(_ completion: @escaping (Any)-> Void){
        requestReturnsData([Post].self, router: PostRouter.getScrapedPost, completion: completion)
    }
}
