//
//  PostRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostRepository {
    func getAllPost(travelId : Int) -> Single<[PostThumbnail]>
    func addPost(travelId : Int, text: String, images : [Data]) -> Single<Int>
    func getOnePost(postId : Int, travelId : Int) -> Single<Post>
    func scrapPost(postId : Int) -> Single<Int>
    func deletePost(postId : Int) -> Single<Int>
    func editPost(postId : Int, editContent : Dictionary<String,Int>) -> Single<Int>
    func getScrapedPost() -> Single<[PostThumbnail]>
}
