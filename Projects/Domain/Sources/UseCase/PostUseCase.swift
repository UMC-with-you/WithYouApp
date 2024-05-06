//
//  PostUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol PostUseCase {
    func getAllPost(travelId : Int) -> Single<[Post]>
    func addPost(travelId : Int, posts: NewPostStruct) -> Single<Void>
    func getOnePost(postId : Int, travelId : Int) -> Single<OnePostResponse>
    func scrapPost(postId : Int) -> Single<Void>
    func deletePost(postId : Int) -> Single<Void>
    func editPost(postId : Int, editContent : Codable) -> Single<Void>
    func getScrapedPost() -> Single<[Post]>
}

final public class DefaultPostUseCase : PostUseCase {
    
    let repository : PostRepository
    
    public init(repository: PostRepository) {
        self.repository = repository
    }
    
    public func getAllPost(travelId: Int) -> Single<[Post]> {
        repository.getAllPost(travelId: travelId)
    }
    
    public func addPost(travelId: Int, posts: NewPostStruct) -> Single<Void> {
        repository.addPost(travelId: travelId, posts: posts)
    }
    
    public func getOnePost(postId: Int, travelId: Int) -> Single<OnePostResponse> {
        repository.getOnePost(postId: postId, travelId: travelId)
    }
    
    public func scrapPost(postId: Int) -> Single<Void> {
        repository.scrapPost(postId: postId)
    }
    
    public func deletePost(postId: Int) -> Single<Void> {
        repository.deletePost(postId: postId)
    }
    
    public func editPost(postId: Int, editContent: any Codable) -> Single<Void> {
        repository.editPost(postId: postId, editContent: editContent)
    }
    
    public func getScrapedPost() -> Single<[Post]> {
        repository.getScrapedPost()
    }
    
    
}
