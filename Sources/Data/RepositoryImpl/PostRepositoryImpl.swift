//
//  PostRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

final public class DefaultPostRepository : PostRepository {
    
    let service = BaseService()
    
    public func getAllPost(travelId: Int) -> Single<[PostThumbnail]> {
        let router = PostRouter.getAllPost(travelId: travelId)
        return service.request(GetAllPostReponseDTO.self, router: router)
    }
    
    public func addPost(travelId: Int, text: String, images : [Data]) -> Single<Int> {
        let dto = AddPostRequestDTO(text: text, images: images)
        let router = PostRouter.addPost(postDTO : dto, travelId: travelId)
        return service.request(AddPostReponseDTO.self, router: router)
    }
    
    public func getOnePost(postId: Int, travelId: Int) -> Single<Post> {
        let router = PostRouter.getOnePost(postId: postId, travelId: travelId)
        return service.request(GetOnePostResponseDTO.self, router: router).map{ $0.toDomain() }
    }
    
    public func scrapPost(postId: Int) -> Single<Int> {
        let router = PostRouter.scrapPost(postId: postId)
        return service.request(DefaultPostResponseDTO.self, router: router).map{ $0.postId }
    }
    
    public func deletePost(postId: Int) -> Single<Int> {
        let router = PostRouter.deletePost(postId: postId)
        return service.request(DefaultPostResponseDTO.self, router: router).map { $0.postId }
    }
    
    //UI 구현 후 설정
    public func editPost(postId: Int, editContent: Dictionary<String,Int>) -> Single<Int> {
        return Single.just(1)
    }
    
    public func getScrapedPost() -> Single<[PostThumbnail]> {
        let router = PostRouter.getScrapedPost
        return service.request(GetScrapedPostResponseDTO.self, router: router)
    }
}
