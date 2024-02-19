    //
//  DetailPostViewController.swift
//  WithYou
//
//  Created by 배수호 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift
import SnapKit

class DetailPostViewController: UIViewController {
    
    var likeCountValue:Int = 0
    
    let navLabel = {
        let label = UILabel()
        label.text = "POST"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오징어들의 오사카여행"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.16 - 2023.11.20"
        label.font = WithYouFontFamily.Pretendard.light.font(size: 12)
        label.textColor = WithYouAsset.gray2.color
        
        return label
    }()
    
    lazy var postCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = WithYouAsset.backgroundColor.color
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
 
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        pageControl.pageIndicatorTintColor = WithYouAsset.subColor.color
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.isEnabled = false
        return pageControl
    }()
    
    
    lazy var likeConfig: UIImage.Configuration = {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        return config
    }()
    
    lazy var messageConfig: UIImage.Configuration = {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        return config
    }()
    
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        //        let image = UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        //        let filledImage = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        let image = UIImage(systemName: "heart",withConfiguration: likeConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let filledImage = UIImage(systemName: "heart.fill",withConfiguration: likeConfig)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        button.setImage(filledImage, for: .selected)
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var messageButton: UIButton = {
        let button = UIButton()
        //        let image = UIImage(systemName: "message")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let image = UIImage(systemName: "message",withConfiguration: messageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(messageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        //        let image = UIImage(systemName: "message")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let fillImage = UIImage(systemName: "bookmark.fill",withConfiguration: messageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let image = UIImage(systemName: "bookmark",withConfiguration: messageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setImage(fillImage, for: .selected)
        button.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.text = "다은"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.text = "님 외 2명이 좋아합니다"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var contextLabel: UILabel = {
        let label = UILabel()
        label.text = "이이번 여밌었다!!v이번 여행"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var bag = DisposeBag()
    
    var post : Post?
    var log : Log?
    var postImage = PublishSubject<[String]>()
    var imageUrls = [String]()
    
    var detailPost : OnePostResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        postImage.subscribe{ images in
            self.imageUrls = images
        }
        .disposed(by: bag)
        
        loadPost()
    }
    
    private func loadPost(){
        PostService.shared.getOnePost(postId: self.post!.postId, travelId: self.log!.id){ response in
            self.detailPost = response
            self.contextLabel.text = response.text
            //이미지파일 가져오기
            var responseUrls = [String]()
            for media in response.postMediaDTO{
                responseUrls.append(media.url)
            }
            self.imageUrls = responseUrls
            self.postCollectionView.reloadData()
            self.pageControl.numberOfPages = responseUrls.count
        }
    }

    public func bind(post:Post, log : Log){
        self.post = post
        self.log = log
        self.titleLabel.text = log.title
        self.periodLabel.text = "\(log.startDate.replacingOccurrences(of: "-", with: ".")) - \(log.endDate.replacingOccurrences(of: "-", with: "."))"
    }
    
    private func setUI() {
        self.navigationItem.titleView = navLabel
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        view.backgroundColor = WithYouAsset.backgroundColor.color
        contentView.addSubview(titleLabel)
        contentView.addSubview(periodLabel)
        contentView.addSubview(postCollectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(likeButton)
        contentView.addSubview(messageButton)
        contentView.addSubview(bookMarkButton)
        contentView.addSubview(likeLabel)
        contentView.addSubview(likeCount)
        contentView.addSubview(contextLabel)
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.id)
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(titleLabel)
        }
        
        postCollectionView.snp.makeConstraints { make in
            make.width.height.equalTo(view.snp.width)
            make.top.equalTo(periodLabel.snp.bottom).offset(15)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postCollectionView.snp.bottom).offset(10)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postCollectionView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        messageButton.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(10)
            make.top.equalTo(likeButton.snp.top)
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.top)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.equalTo(likeButton)
            if likeCountValue == 0 {
                make.height.equalTo(0)
            } else {
                make.height.equalTo(20)
            }
        }
        
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(likeLabel.snp.top)
            make.leading.equalTo(likeLabel.snp.trailing)
            if likeCountValue == 0 {
                make.height.equalTo(0)
            } else {
                make.height.equalTo(20)
            }
        }
        
        contextLabel.snp.makeConstraints { make in
            make.top.equalTo(likeCount.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
        // Calculate contentView's height based on contextLabel's content
        contentView.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentView.frame.height)
    }

    //MARK: - 버튼 터치 이벤트 메서드
    @objc func likeButtonTapped() {
        likeButton.isSelected.toggle()
        if likeButton.isSelected {
                    likeCountValue += 1
                } else {
                    likeCountValue -= 1
                }
        if likeCountValue != 0 {
            likeLabel.snp.remakeConstraints { make in
                make.height.equalTo(20)
                make.top.equalTo(likeButton.snp.bottom).offset(10)
                make.leading.equalTo(likeButton.snp.leading)
            }
            likeCount.snp.remakeConstraints { make in
                
                make.height.equalTo(20)
                make.top.equalTo(likeButton.snp.bottom).offset(10)
                make.leading.equalTo(likeLabel.snp.trailing)
            }
        }
        else {
            likeLabel.snp.remakeConstraints { make in
                make.height.equalTo(0)
                make.top.equalTo(likeButton.snp.bottom).offset(10)
                make.leading.equalTo(likeButton.snp.leading)
            }
            likeCount.snp.remakeConstraints { make in
                make.height.equalTo(0)
                make.top.equalTo(likeButton.snp.bottom).offset(10)
                make.leading.equalTo(likeLabel.snp.trailing)
            }
        }
        likeCount.text = "님 외\(likeCountValue)명이 좋아합니다."
    }
    
    @objc func messageButtonTapped() {
        let modalViewController = CommentModalViewController()
        modalViewController.post = self.post
        if let comments = detailPost?.commentDTOs {
            modalViewController.commentRelay.accept(comments.map{$0!})
        }
        
        self.present(modalViewController, animated: true)
    }
    
    @objc func bookMarkButtonTapped() {
        bookMarkButton.isSelected.toggle()
        PostService.shared.scrapPost(postId: self.post!.postId){ _ in
            
        }
    }
}

extension UIButton {
    func setImage(systemName: String) {
        // 가로, 세로 정렬
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        // 이미지를 꽉차게 만듬
        imageView?.contentMode = .scaleAspectFit
        // 기존 setImage 메소드
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}

extension DetailPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / view.frame.width)
        self.pageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.id, for: indexPath)
        if let cell = cell as? PostCollectionViewCell {
            cell.postImageView.kf.setImage(with:URL(string: imageUrls[indexPath.row]))
        }
        return cell
    }
}

extension DetailPostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        
    }
}

