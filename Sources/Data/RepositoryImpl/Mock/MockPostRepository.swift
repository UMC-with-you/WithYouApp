//
//  MockPostRepository.swift
//  Data
//
//  Created by bryan on 7/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

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
    
    var posts: [Post] = [
        Post(
            postId: 1,
            memberId: 1,
            text: "Had a great time at the beach!",
            comments: [
                Comment(postId: 1, memberId: 2, commentId: 1, content: "Looks awesome!", replys: [
                    Reply(commentId: 1, replyId: 1, content: "It was amazing!", memberId: 1)
                ])
            ],
            images: [
                PostImage(imageId: 1, imageUrl: "https://example.com/beach1.jpg", position: 1),
                PostImage(imageId: 2, imageUrl: "https://example.com/beach2.jpg", position: 2),
                PostImage(imageId: 2, imageUrl: "https://example.com/beach2.jpg", position: 3),
                PostImage(imageId: 2, imageUrl: "https://example.com/beach2.jpg", position: 4)
            ]
        ),
        Post(
            postId: 2,
            memberId: 3,
            text: "Just finished a delicious meal at the new restaurant!",
            comments: [
                Comment(postId: 2, memberId: 4, commentId: 2, content: "The food looks great!", replys: []),
                Comment(postId: 2, memberId: 5, commentId: 3, content: "I need to visit that place!", replys: [])
            ],
            images: [
                PostImage(imageId: 3, imageUrl: "https://example.com/food1.jpg", position: 1)
            ]
        ),
        Post(
            postId: 3,
            memberId: 2,
            text: "Hiking through the mountains was such an adventure!",
            comments: [
                Comment(postId: 3, memberId: 1, commentId: 4, content: "The view is incredible!", replys: [
                    Reply(commentId: 4, replyId: 2, content: "It was even better in person!", memberId: 2)
                ]),
                Comment(postId: 3, memberId: 6, commentId: 5, content: "Can't wait to go hiking again!", replys: [])
            ],
            images: [
                PostImage(imageId: 4, imageUrl: "https://example.com/hike1.jpg", position: 1),
                PostImage(imageId: 5, imageUrl: "https://example.com/hike2.jpg", position: 2),
                PostImage(imageId: 6, imageUrl: "https://example.com/hike3.jpg", position: 3)
            ]
        ),
        Post(
            postId: 4,
            memberId: 4,
            text: "Visited the city and explored some amazing architecture!",
            comments: [
                Comment(postId: 4, memberId: 2, commentId: 6, content: "The buildings look stunning!", replys: []),
                Comment(postId: 4, memberId: 1, commentId: 7, content: "Which part of the city is this?", replys: [
                    Reply(commentId: 7, replyId: 3, content: "It's the downtown area!", memberId: 4)
                ])
            ],
            images: [
                PostImage(imageId: 7, imageUrl: "https://example.com/city1.jpg", position: 1),
                PostImage(imageId: 8, imageUrl: "https://example.com/city2.jpg", position: 2)
            ]
        ),
        Post(
            postId: 5,
            memberId: 5,
            text: "Spent the day relaxing in the park with some good books.",
            comments: [
                Comment(postId: 5, memberId: 3, commentId: 8, content: "That sounds like the perfect day!", replys: []),
                Comment(postId: 5, memberId: 6, commentId: 9, content: "What books were you reading?", replys: [])
            ],
            images: [
                PostImage(imageId: 9, imageUrl: "https://example.com/park1.jpg", position: 1),
                PostImage(imageId: 10, imageUrl: "https://example.com/park2.jpg", position: 2)
            ]
        )
    ]
    
    public func getAllPost(travelId: Int) -> Single<[PostThumbnail]> {
        .just(postThumbnails)
    }
    
    public func addPost(travelId: Int, text: String, images: [Data]) -> Single<Int> {
        posts.append(Post(postId: posts.count, memberId: 0, text: text, comments: [], images: []))
        return .just(0)
    }
    
    public func getOnePost(postId: Int, travelId: Int) -> Single<Post> {
        //return .just(posts.filter{ $0.postId == postId}.first!)
        return .just(self.posts.first!)
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
