//
//  PostDetailViewModel.swift
//  WithYou
//
//  Created by bryan on 9/18/24.
//

import Foundation
import RxSwift

final public class PostDetailViewModel {
    
    private let postUseCase: PostUseCase
    private let disposeBag = DisposeBag()
    
    public var post : PublishSubject<Post> = PublishSubject()
    public var postImages = PublishSubject<[PostImage]>()
    private let postId : Int
    public let log : Log
    
    init(postUseCase: PostUseCase, postId: Int, log: Log) {
        self.postUseCase = postUseCase
        self.postId = postId
        self.log = log
    }
    
    func fetchPosts() {
        postUseCase.getOnePost(postId: postId, travelId: self.log.id)
            .subscribe(onSuccess: { [weak self] onePost in
                self?.post.onNext(onePost)
            })
            .disposed(by: disposeBag)
    }
    
    public func bindImages(_ images : [PostImage]){
        self.postImages.onNext(images)
    }
}
