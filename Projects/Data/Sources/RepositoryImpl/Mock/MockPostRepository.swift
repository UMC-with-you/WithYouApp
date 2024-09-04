//
//  MockPostRepository.swift
//  Data
//
//  Created by bryan on 7/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import Foundation
import RxSwift

public final class MockPostRepository : PostRepository {
    
    var postThumbnails = [
        PostThumbnail(postId: 0, thumbnailUrl: ""),
        PostThumbnail(postId: 1, thumbnailUrl: ""),
        PostThumbnail(postId: 2, thumbnailUrl: ""),
        PostThumbnail(postId: 3, thumbnailUrl: ""),
        PostThumbnail(postId: 4, thumbnailUrl: ""),
        PostThumbnail(postId: 5, thumbnailUrl: "")
    ]
    
    var posts : [Post]
    
    public init(){
        self.posts = []
        self.posts = makePosts()
    }
    
    public func getAllPost(travelId: Int) -> Single<[PostThumbnail]> {
        .just(postThumbnails)
    }
    
    public func addPost(travelId: Int, text: String, images: [Data]) -> Single<Int> {
        posts.append(Post(postId: posts.count, memberId: 0, text: text, comments: [], images: []))
        return .just(0)
    }
    
    public func getOnePost(postId: Int, travelId: Int) -> Single<Post> {
        return .just(posts.filter{ $0.postId == postId}.first!)
    }
    
    public func scrapPost(postId: Int) -> Single<Int> {
        .just(0)
    }
    
    public func deletePost(postId: Int) -> Single<Int> {
        .just(0)
    }
    
    public func editPost(postId: Int, editContent: Dictionary<String, Int>) -> Single<Int> {
        .just(0)
    }
    
    public func getScrapedPost() -> Single<[PostThumbnail]> {
        .just(postThumbnails)
    }
    
    func makePosts() -> [Post] {
        return (0..<5).map{
            Post(postId: $0, memberId: 0, text: "", comments: [], images: [])
        }
    }
}
