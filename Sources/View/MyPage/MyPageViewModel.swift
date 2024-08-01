//
//  MyPageViewModel.swift
//  WithYou
//
//  Created by 이승진 on 2024/07/07.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class MyPageViewModel {
    private let bag = DisposeBag()
    var underLineConst : Constraint?
    // Input
    let viewDidLoad = PublishRelay<Void>()
    let refreshControlPulled = PublishRelay<Void>()
    let scrapLabelTapped = PublishRelay<Void>()
    let myLabelTapped = PublishRelay<Void>()
    
    // Output
    let posts = BehaviorRelay<[PostWithLogId]>(value: [])
    let linePosition = BehaviorRelay<Bool>(value: true)
    let userName = BehaviorRelay<String>(value: DataManager.shared.getUserName())
    let userImage = BehaviorRelay<Data>(value: DataManager.shared.getUserImage())
    
    var scrapPost = [PostWithLogId]()
    var myPost = [PostWithLogId]()
    
    //    var posts = BehaviorSubject<[PostWithLogId]>(value: [])
        
    //    var scrapPost = [PostWithLogId]()
    //    var myPost = [PostWithLogId]()
        
    //    var linePosition = BehaviorRelay<Bool>(value: true)
    
    init() {
        // Binding Inputs
        viewDidLoad
            .subscribe(onNext: { [weak self] in
                self?.loadPosts()
            })
            .disposed(by: bag)
        
        refreshControlPulled
            .subscribe(onNext: { [weak self] in
                self?.loadPosts()
            })
            .disposed(by: bag)
        
        scrapLabelTapped
            .subscribe(onNext: { [weak self] in
                self?.linePosition.accept(true)
            })
            .disposed(by: bag)
        
        myLabelTapped
            .subscribe(onNext: { [weak self] in
                self?.linePosition.accept(false)
            })
            .disposed(by: bag)
        
        linePosition
            .subscribe(onNext: { [weak self] isScrap in
                self?.posts.accept(isScrap ? self?.scrapPost ?? [] : self?.myPost ?? [])
            })
            .disposed(by: bag)
    }
    
    private func loadPosts() {
        // Scrap
        scrapPost = []
        PostService.shared.getScrapedPost { scrapPosts in
            LogService.shared.getAllLogs { logs in
                let logIdSet = Set<Int>(logs.map { $0.id })
                for id in logIdSet {
                    PostService.shared.getAllPost(travelId: id) { posts in
                        for post in posts {
                            if scrapPosts.contains(post) {
                                self.scrapPost.append(PostWithLogId(post: post, travelId: id))
                            }
                        }
                    }
                }
            }
        }
        
        // My
        myPost = []
        let localPostDTO = DataManager.shared.getMyPost()
        let travelSet = Set<Int>(localPostDTO.map { $0.travelId })
        let postSet = Set<Int>(localPostDTO.map { $0.postId })
        for logId in travelSet {
            PostService.shared.getAllPost(travelId: logId) { posts in
                for post in posts {
                    if postSet.contains(post.postId) {
                        self.myPost.append(PostWithLogId(post: post, travelId: logId))
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            if self.linePosition.value {
                self.posts.accept(self.scrapPost)
            } else {
                self.posts.accept(self.myPost)
            }
        }
    }
}

