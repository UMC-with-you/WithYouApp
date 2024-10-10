//
//  PostUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostUseCase {
    func getAllPost(travelId : Int) -> Single<[PostThumbnail]>
    func addPost(travelId : Int, text: String, images : [Data]) -> Single<Int>
    func getOnePost(postId : Int, travelId : Int) -> Single<Post>
    func scrapPost(postId : Int) -> Single<Int>
    func deletePost(postId : Int) -> Single<Int>
    func editPost(postId : Int, editContent : Dictionary<String,Int>) -> Single<Int>
    func getScrapedPost() -> Single<[PostThumbnail]>
}

final public class DefaultPostUseCase : PostUseCase {
    
    let repository : PostRepository
    
    public init(repository: PostRepository) {
        self.repository = repository
    }
    
    public func getAllPost(travelId: Int) -> Single<[PostThumbnail]> {
        repository.getAllPost(travelId: travelId)
    }
    
    public func addPost(travelId: Int, text: String, images : [Data]) -> Single<Int> {
        repository.addPost(travelId: travelId, text: text, images : images)
    }
    
    public func getOnePost(postId: Int, travelId: Int) -> Single<Post> {
        repository.getOnePost(postId: postId, travelId: travelId)
    }
    
    public func scrapPost(postId: Int) -> Single<Int> {
        repository.scrapPost(postId: postId)
    }
    
    public func deletePost(postId: Int) -> Single<Int> {
        repository.deletePost(postId: postId)
    }
    
    public func editPost(postId: Int, editContent: Dictionary<String,Int>) -> Single<Int> {
        repository.editPost(postId: postId, editContent: editContent)
    }
    
    public func getScrapedPost() -> Single<[PostThumbnail]> {
        repository.getScrapedPost()
    }
    
    
}
