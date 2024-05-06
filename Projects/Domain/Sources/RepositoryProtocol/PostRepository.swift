//
//  PostRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol PostRepository {
    func getAllPost(travelId : Int) -> Single<[Post]>
    func addPost(travelId : Int, posts: NewPostStruct) -> Single<Void>
    func getOnePost(postId : Int, travelId : Int) -> Single<OnePostResponse>
    func scrapPost(postId : Int) -> Single<Void>
    func deletePost(postId : Int) -> Single<Void>
    func editPost(postId : Int, editContent : Codable) -> Single<Void>
    func getScrapedPost() -> Single<[Post]>
}
