//
//  PostListViewmodel.swift
//  TravelLogFeature
//
//  Created by bryan on 7/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

import RxSwift

public final class PostListViewmodel {
    
    public var posts = PublishSubject<[PostThumbnail]>()
    
    private var postUseCase : PostUseCase
    
    public let log : Log
    
    private var disposeBag = DisposeBag()
    
    public init(postUseCase: PostUseCase, log: Log) {
        self.postUseCase = postUseCase
        self.log = log
    }
    
    public func loadPost() {
        postUseCase.getAllPost(travelId: log.id)
            .subscribe { [weak self] thumbnails in
                self?.posts.onNext(thumbnails)
            } onFailure: { error in
                print(error)
            }.disposed(by:disposeBag)
    }
}
