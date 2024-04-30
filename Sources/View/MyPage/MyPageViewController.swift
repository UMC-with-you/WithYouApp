//
//  MyPageViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Kingfisher
import RxGesture
import RxSwift
import RxCocoa
import UIKit
import SnapKit

final class MyPageViewController: BaseViewController {
    
    //UI Components
    var myPageView = MyPageView()

    var bag = DisposeBag()
    
    var posts = BehaviorSubject<[PostWithLogId]>(value: [])
    
    var scrapPost = [PostWithLogId]()
    var myPost = [PostWithLogId]()
    
    var linePosition = BehaviorRelay<Bool>(value: true)
    
    override func viewWillAppear(_ animated: Bool) {
        loadPosts()
        //nickNameLabel.text = DataManager.shared.getUserName()
        //profileView.profileImage.image = UIImage(data:DataManager.shared.getUserImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func setUp(){
        view.addSubview(myPageView)
    }
    
    override func setLayout() {
        myPageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setUpBind(){
    }
    
    private func loadPosts(){
//        //Scrap
//        scrapPost = []
//        PostService.shared.getScrapedPost { scrapPosts in
//            LogService.shared.getAllLogs { logs in
//                let logIdSet = Set<Int>(logs.map{$0.id})
//                for id in logIdSet {
//                    PostService.shared.getAllPost(travelId: id){ posts in
//                        for post in posts {
//                            if scrapPosts.contains(post){
//                                self.scrapPost.append(PostWithLogId(post:post,travelId: id))
//                            }
//                        }
//                        
//                    }
//                }
//            }
//        }
//        
//        //My
//        myPost = []
//        let localPostDTO = DataManager.shared.getMyPost()
//        let travelSet = Set<Int>(localPostDTO.map{$0.travelId})
//        let postSet = Set<Int>(localPostDTO.map({$0.postId}))
//        for logId in travelSet {
//            PostService.shared.getAllPost(travelId: logId){ posts in
//                for post in posts{
//                    if postSet.contains(post.postId) {
//                        self.myPost.append(PostWithLogId(post: post, travelId: logId))
//                    }
//                }
//            }
//        }
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//            if self.linePosition.value {
//                self.posts.onNext(self.scrapPost)
//            } else {
//                self.posts.onNext(self.myPost)
//            }
//        }
    }
    
    private func setCollectionView() {
//        // 포스트
//        myPageCollectionView.register(PostGridCollectionViewCell.self, forCellWithReuseIdentifier: PostGridCollectionViewCell.identifier)
//        configureRefreshControl()
//        
//        posts.bind(to: myPageCollectionView.rx.items(cellIdentifier: PostGridCollectionViewCell.identifier, cellType: PostGridCollectionViewCell.self)){ index, item,cell in
//            cell.postImageView.kf.setImage(with: URL(string: item.post.thumbnailUrl))
//        }
//        .disposed(by: bag)
//        
//        myPageCollectionView
//            .rx
//            .modelSelected(PostWithLogId.self)
//            .subscribe(onNext: { postWithId in
//                let newVC = DetailPostViewController()
//                LogService.shared.getAllLogs { logs in
//                    for log in logs {
//                        if log.id == postWithId.travelId{
//                            newVC.bind(post: postWithId.post, log: log)
//                            self.navigationController?.pushViewController(newVC, animated: true)
//                            break
//                        }
//                    }
//                }
//                
//            })
//        .disposed(by: bag)
    }
    
    private func setRx(){
//        scrapLabel.rx.tapGesture()
//            .when(.recognized)
//            .subscribe{ [unowned self] _ in
//            linePosition.accept(true)
//                
//        }
//        .disposed(by: bag)
//        
//        myLabel.rx.tapGesture()
//            .when(.recognized)
//            .subscribe{ [unowned self] _ in
//            linePosition.accept(false)
//        }
//        .disposed(by: bag)
//        
//        linePosition.subscribe { [unowned self] _ in
//            self.underLineConst?.deactivate()
//            self.underlineView.snp.makeConstraints{
//                self.underLineConst = $0.centerX.equalTo(linePosition.value ? scrapLabel.snp.centerX : myLabel.snp.centerX).constraint
//            }
//            
//            if linePosition.value {
//                self.posts.onNext(self.scrapPost)
//            } else {
//                self.posts.onNext(self.myPost)
//            }
//        }
//        .disposed(by:bag)
    }
    
    private func setConst(){
        
    }
    
    // 당겨서 새로고침
//    func configureRefreshControl () {
//        myPageCollectionView.refreshControl = UIRefreshControl()
//        myPageCollectionView.refreshControl?.addTarget(self, action:
//                                                    #selector(handleRefreshControl),
//                                                 for: .valueChanged)
//    }
    
//    @objc func handleRefreshControl() {
//        loadPosts()
//        DispatchQueue.main.async{
//            self.myPageCollectionView.refreshControl?.endRefreshing()
//        }
//    }
    
    @objc func editButtonTapped() {
        if let navController = self.navigationController {
            let profileEditController = ProfileEditViewController()
            navController.pushViewController(profileEditController, animated: true)
        }
    }
}
