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

public protocol MyPageViewControllerDelgate {
    
}

public class MyPageViewController: BaseViewController {
    private let myPageView = MyPageView()
    private let viewModel: MyPageViewModel
    private var linePosition = BehaviorRelay<Bool>(value: true)
    
    public var coordinator: MyPageViewControllerDelgate?
    
    // ViewModel
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // View
    public override func viewWillAppear(_ animated: Bool) {
        
//        viewModel.loadPosts()
//        myPageView.moveEclipse(state: true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Rx 연결
    public override func setFunc() {
        // 스크랩 라벨 터치 시 ViewModel의 linePosition 업데이트
        myPageView.scrapLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe { [unowned self] _ in
                viewModel.updateLinePosition(true)
            }
            .disposed(by: disposeBag)
        
        // 나의 라벨 터치 시 ViewModel의 linePosition 업데이트
        myPageView.myLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe { [unowned self] _ in
                viewModel.updateLinePosition(false)
            }
            .disposed(by: disposeBag)
        
        // ViewModel의 linePosition 값을 구독하여 언더라인 위치와 게시물 전환
        viewModel.linePosition
            .subscribe(onNext: { [unowned self] isScrapSelected in
                // 언더라인 위치 업데이트
                self.myPageView.underLineConst?.deactivate()
                self.myPageView.underlineView.snp.makeConstraints {
                    self.myPageView.underLineConst = $0.centerX.equalTo(isScrapSelected ? myPageView.scrapLabel.snp.centerX : myPageView.myLabel.snp.centerX).constraint
                }
                // 게시물 목록 전환
                self.viewModel.togglePosts()
            })
            .disposed(by: disposeBag)
        
        // ViewModel의 posts를 myPageView의 CollectionView에 바인딩
        viewModel.posts
            .bind(to: myPageView.myPageCollectionView.rx.items(cellIdentifier: PostListCell.cellId, cellType: PostListCell.self)) { _, post, cell in
                cell.thumb.image = UIImage(named: post.thumbnailUrl)
            }
            .disposed(by: disposeBag)
    }

    
//    // MARK: - Rx 연결
//    public override func setFunc() {
//        myPageView.scrapLabel.rx.tapGesture()
//            .when(.recognized)
//            .subscribe{ [unowned self] _ in
//                linePosition.accept(true)
//                
//            }
//            .disposed(by: disposeBag)
//        
//        myPageView.myLabel.rx.tapGesture()
//            .when(.recognized)
//            .subscribe{ [unowned self] _ in
//                linePosition.accept(false)
//            }
//            .disposed(by: disposeBag)
//        
//        linePosition.subscribe { [unowned self] _ in
//            self.myPageView.underLineConst?.deactivate()
//            self.myPageView.underlineView.snp.makeConstraints{
//                self.myPageView.underLineConst = $0.centerX.equalTo(linePosition.value ? myPageView.scrapLabel.snp.centerX : myPageView.myLabel.snp.centerX).constraint
//            }
//            
//            if linePosition.value {
//                self.posts.onNext(self.myPageViewscrapPost)
//            } else {
//                self.posts.onNext(self.myPost)
//            }
//        }
//        .disposed(by: disposeBag)
//    }
    
    // MARK: - 사용자 터치 이벤트
    private func setActions() {
        
    }
    
    // MARK: - ViewController
    public override func setUpViewProperty() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "MY"
    }
    
    public override func setUp() {
//        [myPageView].forEach {
//            view.addSubview($0)
//        }
        view.addSubview(myPageView)
    }
    
    public override func setDelegate() {
        myPageView.myPageCollectionView.delegate = self
    }
    
    public override func setLayout() {
        myPageView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    
}



//final class MyPageViewController: BaseViewController {
//    
//    //UI Components
//    let topLabel = {
//        let label = UILabel()
//        label.text = "MY"
//        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
//        label.textAlignment = .center
//        label.textColor = WithYouAsset.mainColorDark.color
//        return label
//        
//    }()
//    let myPageCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 1, height: UIScreen.main.bounds.width / 3 - 1)
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return collectionView
//    }()
//    
//    let profileView = {
//        let view = ProfileView(size: .my)
//        return view
//    }()
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "여행초보"
//        label.textColor = UIColor(red: 0.85, green: 0.7, blue: 0.28, alpha: 1)
//        label.font = UIFont(name: "Pretendard-SemiBold", size: 11)
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.layer.masksToBounds = true
//        label.layer.borderWidth = 1
//        label.layer.cornerRadius = 10
//        label.layer.borderColor = UIColor(red: 0.85, green: 0.7, blue: 0.28, alpha: 1).cgColor
//        return label
//    }()
//    
//    let nickNameLabel: UILabel = {
//        let label = UILabel()
//        //        label.text = DataManager.shared.getUserName()
//        label.textColor = .black
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.font = UIFont(name: "Pretendard-Medium", size: 20)
//        return label
//    }()
//    
//    let editButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("프로필 수정", for: .normal)
//        button.setTitleColor(UIColor.gray, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize:13)
//        button.layer.masksToBounds = true
//        button.layer.borderWidth = 1
//        button.layer.cornerRadius = 15
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    let stackView: UIStackView = {
//        let sv = UIStackView()
//        sv.spacing = 10
//        sv.axis = .vertical
//        sv.alignment = .fill
//        sv.distribution = .fill
//        return sv
//    }()
//    
//    let scrapLabel: UILabel = {
//        let label = UILabel()
//        label.text = "SCRAP"
//        label.textColor = UIColor(named: "MainColorDark")
//        label.font = UIFont(name: "Pretendard-Medium", size: 18)
//        return label
//    }()
//    
//    let underlineView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "MainColorDark")
//        return view
//    }()
//    
//    let myLabel: UILabel = {
//        let label = UILabel()
//        label.text = "My"
//        label.textColor = .lightGray
//        label.font = UIFont(name: "Pretendard-Medium", size: 18)
//        return label
//    }()
//    
//    var bag = DisposeBag()
//    
//    var underLineConst : Constraint?
//    var posts = BehaviorSubject<[PostWithLogId]>(value: [])
//    
//    var scrapPost = [PostWithLogId]()
//    var myPost = [PostWithLogId]()
//    
//    var linePosition = BehaviorRelay<Bool>(value: true)
//    
//    override func viewWillAppear(_ animated: Bool) {
//        loadPosts()
//        nickNameLabel.text = DataManager.shared.getUserName()
//        profileView.profileImage.image = UIImage(data:DataManager.shared.getUserImage())
//    }
//    
//    override func viewDidLoad() {
//        setRx()
//        setCollectionView()
//        loadPosts()
//    }
//    
//    private func loadPosts(){
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
//        // My
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
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//            if self.linePosition.value {
//                self.posts.onNext(self.scrapPost)
//            } else {
//                self.posts.onNext(self.myPost)
//            }
//        }
//    }
//    
//    private func setCollectionView() {
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
//            .disposed(by: bag)
//    }
//    
//    private func setRx(){
//        scrapLabel.rx.tapGesture()
//            .when(.recognized)
//            .subscribe{ [unowned self] _ in
//                linePosition.accept(true)
//                
//            }
//            .disposed(by: bag)
//        
//        myLabel.rx.tapGesture()
//            .when(.recognized)
//            .subscribe{ [unowned self] _ in
//                linePosition.accept(false)
//            }
//            .disposed(by: bag)
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
//    }
//    
//    override func setUpViewProperty() {
//        self.navigationItem.titleView = topLabel
//        view.backgroundColor = .white
//    }
//    
//    override func setUp() {
//        [profileView,titleLabel,nickNameLabel,editButton,scrapLabel, myLabel,underlineView,myPageCollectionView].forEach{
//            view.addSubview($0)
//        }
//    }
//    
//    override func setLayout() {
//        profileView.snp.makeConstraints{
//            $0.leading.equalToSuperview().offset(20)
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
//        }
//        titleLabel.snp.makeConstraints{
//            $0.top.equalTo(profileView.snp.top).offset(5)
//            $0.leading.equalTo(profileView.snp.trailing).offset(10)
//            $0.width.equalTo(55)
//            $0.height.equalTo(20)
//        }
//        
//        nickNameLabel.snp.makeConstraints{
//            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
//            $0.leading.equalTo(titleLabel.snp.leading)
//        }
//        
//        editButton.snp.makeConstraints{
//            $0.centerY.equalTo(profileView.snp.centerY)
//            $0.trailing.equalToSuperview().offset(-15)
//            $0.width.equalTo(85)
//            $0.height.equalTo(30)
//        }
//        
//        scrapLabel.snp.makeConstraints{
//            $0.leading.equalToSuperview().offset(100)
//            $0.top.equalTo(nickNameLabel.snp.bottom).offset(60)
//        }
//        
//        myLabel.snp.makeConstraints{
//            $0.trailing.equalToSuperview().offset(-120)
//            $0.centerY.equalTo(scrapLabel)
//        }
//        underlineView.snp.makeConstraints {
//            $0.top.equalTo(scrapLabel.snp.bottom).offset(1)
//            self.underLineConst = $0.centerX.equalTo(scrapLabel.snp.centerX).constraint
//            $0.height.equalTo(3)
//            $0.width.equalTo(scrapLabel.snp.width)
//        }
//        myPageCollectionView.snp.makeConstraints{
//            $0.width.equalToSuperview()
//            $0.top.equalTo(underlineView.snp.bottom).offset(2)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    
//    // 당겨서 새로고침
//    func configureRefreshControl () {
//        myPageCollectionView.refreshControl = UIRefreshControl()
//        myPageCollectionView.refreshControl?.addTarget(self, action:
//                                                        #selector(handleRefreshControl),
//                                                       for: .valueChanged)
//    }
//    
//    @objc func handleRefreshControl() {
//        loadPosts()
//        DispatchQueue.main.async{
//            self.myPageCollectionView.refreshControl?.endRefreshing()
//        }
//    }
//    
//    @objc func editButtonTapped() {
//        if let navController = self.navigationController {
//            let profileEditController = ProfileEditViewController()
//            navController.pushViewController(profileEditController, animated: true)
//        }
//    }
//}
