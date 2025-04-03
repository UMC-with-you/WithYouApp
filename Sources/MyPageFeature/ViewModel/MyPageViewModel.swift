//
//  MyPageViewModel.swift
//  WithYou
//
//  Created by 이승진 on 10/14/24.
//

import RxCocoa
import RxSwift

public final class MyPageViewModel {
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var useCase: PostUseCase
    
    private var scrapPosts: [PostThumbnail] = []
    private var myPosts: [PostThumbnail] = []
    
    // Relays
    var linePosition = BehaviorRelay<Bool>(value: true)
    var isPostEmpty = PublishRelay<Bool>()
    
    // Subjects
    var posts = PublishSubject<[PostThumbnail]>()
    
    // MARK: - Initializer
    public init(useCase: PostUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Functions
    
    /// 스크랩된 게시물을 로드하는 함수
    public func loadScrapPosts() {
        useCase.getScrapedPost()
            .subscribe(onSuccess: { [weak self] newPosts in
                if newPosts.isEmpty {
                    self?.isPostEmpty.accept(true)
                } else {
                    self?.scrapPosts = newPosts
                    self?.posts.onNext(newPosts)
                    self?.isPostEmpty.accept(false)
                }
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    /// 특정 여행 ID의 게시물 로드를 위한 함수
    public func loadMyPosts(for travelId: Int) {
        useCase.getAllPost(travelId: travelId)
            .subscribe(onSuccess: { [weak self] newPosts in
                if newPosts.isEmpty {
                    self?.isPostEmpty.accept(true)
                } else {
                    self?.myPosts = newPosts
                    self?.posts.onNext(newPosts)
                    self?.isPostEmpty.accept(false)
                }
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    /// 현재 선택된 게시물 목록을 토글하는 함수
    public func togglePosts() {
        if linePosition.value {
            posts.onNext(scrapPosts)
        } else {
            posts.onNext(myPosts)
        }
    }
    
    /// `linePosition` 업데이트 후 게시물 목록을 토글
    public func updateLinePosition(_ isScrapPostSelected: Bool) {
        linePosition.accept(isScrapPostSelected)
        togglePosts()
    }
    
    /// 로컬 데이터를 통해 `myPosts`를 분류하는 함수
    private func classifyLocalPosts() {
        var newMyPosts: [PostThumbnail] = []
        
        // 1. 스크랩된 게시물 가져오기
        useCase.getScrapedPost()
            .asObservable() // Single을 Observable로 변환
            .flatMap { [weak self] scrapedPosts -> Observable<Post> in
                guard let self = self else { return Observable.empty() }
                
                // 각각의 스크랩된 게시물의 상세 정보 조회
                let postObservables = scrapedPosts.map { thumbnail in
                    self.useCase.getOnePost(postId: thumbnail.postId, travelId: 1).asObservable()
                }
                
                // 모든 Post를 합쳐서 Observable로 반환
                return Observable.merge(postObservables)
            }
            .subscribe(onNext: { [weak self] post in
                guard let self = self else { return }
                
                // 가져온 Post를 myPosts에 추가
                newMyPosts.append(PostThumbnail(postId: post.postId, thumbnailUrl: post.text)) // 필요한 정보만 추가
                self.myPosts = newMyPosts
                self.posts.onNext(newMyPosts)
                
            }, onError: { error in
                print("Error fetching post details: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
