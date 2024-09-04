//
//  PostDetailViewController.swift
//  TravelLogFeature
//
//  Created by bryan on 8/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Domain
import UIKit

class DetailPostViewController: BaseViewController {
    
    var likeCountValue:Int = 0
    
    let postView = PostDetailView()
    
    let navLabel = {
        let label = UILabel()
        label.text = "POST"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        return label
    }()
    
    override func viewDidLoad() {
    }
    
    private func setUI() {
        //        self.navigationItem.titleView = navLabel
        //
        //
        //        scrollView.snp.makeConstraints {
        //            $0.top.equalTo(view.safeAreaLayoutGuide)
        //            $0.leading.trailing.equalToSuperview()
        //            $0.bottom.equalToSuperview()
        //        }
        //
        //        contentView.snp.makeConstraints {
        //            $0.edges.equalToSuperview()
        //            $0.width.equalToSuperview()
        //            $0.height.greaterThanOrEqualToSuperview()
        //        }
        //
        //        view.backgroundColor = WithYouAsset.backgroundColor.color
        //        contentView.addSubview(titleLabel)
        //        contentView.addSubview(periodLabel)
        //        contentView.addSubview(postCollectionView)
        //        contentView.addSubview(pageControl)
        //        contentView.addSubview(likeButton)
        //        contentView.addSubview(messageButton)
        //        contentView.addSubview(bookMarkButton)
        //        contentView.addSubview(likeLabel)
        //        contentView.addSubview(likeCount)
        //        contentView.addSubview(contextLabel)
        //        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.id)
        //
        //        postCollectionView.delegate = self
        //        postCollectionView.dataSource = self
        //        titleLabel.snp.makeConstraints { make in
        //            make.top.equalToSuperview().offset(10)
        //            make.centerX.equalToSuperview()
        //        }
        //
        //        periodLabel.snp.makeConstraints { make in
        //            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        //            make.centerX.equalTo(titleLabel)
        //        }
        //
        //        postCollectionView.snp.makeConstraints { make in
        //            make.width.height.equalTo(view.snp.width)
        //            make.top.equalTo(periodLabel.snp.bottom).offset(15)
        //        }
        //
        //        pageControl.snp.makeConstraints { make in
        //            make.centerX.equalToSuperview()
        //            make.top.equalTo(postCollectionView.snp.bottom).offset(10)
        //        }
        //
        //        likeButton.snp.makeConstraints { make in
        //            make.top.equalTo(postCollectionView.snp.bottom).offset(15)
        //            make.leading.equalToSuperview().offset(15)
        //        }
        //
        //        messageButton.snp.makeConstraints { make in
        //            make.leading.equalTo(likeButton.snp.trailing).offset(10)
        //            make.top.equalTo(likeButton.snp.top)
        //        }
        //
        //        bookMarkButton.snp.makeConstraints { make in
        //            make.top.equalTo(likeButton.snp.top)
        //            make.trailing.equalToSuperview().offset(-15)
        //        }
        //
        //        likeLabel.snp.makeConstraints { make in
        //            make.top.equalTo(likeButton.snp.bottom).offset(10)
        //            make.leading.equalTo(likeButton)
        //            if likeCountValue == 0 {
        //                make.height.equalTo(0)
        //            } else {
        //                make.height.equalTo(20)
        //            }
        //        }
        //
        //        likeCount.snp.makeConstraints { make in
        //            make.top.equalTo(likeLabel.snp.top)
        //            make.leading.equalTo(likeLabel.snp.trailing)
        //            if likeCountValue == 0 {
        //                make.height.equalTo(0)
        //            } else {
        //                make.height.equalTo(20)
        //            }
        //        }
        //
        //        contextLabel.snp.makeConstraints { make in
        //            make.top.equalTo(likeCount.snp.bottom).offset(5)
        //            make.centerX.equalToSuperview()
        //            make.leading.equalToSuperview().offset(15)
        //            make.trailing.equalToSuperview().offset(-15)
        //            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        //        }
        //
        //        // Calculate contentView's height based on contextLabel's content
        //        contentView.layoutIfNeeded()
        //        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentView.frame.height)
        //    }
        //
        //    //MARK: - 버튼 터치 이벤트 메서드
        //    @objc func likeButtonTapped() {
        //        likeButton.isSelected.toggle()
        //        if likeButton.isSelected {
        //            likeCountValue += 1
        //        } else {
        //            likeCountValue -= 1
        //        }
        //        if likeCountValue != 0 {
        //            likeLabel.snp.remakeConstraints { make in
        //                make.height.equalTo(20)
        //                make.top.equalTo(likeButton.snp.bottom).offset(10)
        //                make.leading.equalTo(likeButton.snp.leading)
        //            }
        //            likeCount.snp.remakeConstraints { make in
        //
        //                make.height.equalTo(20)
        //                make.top.equalTo(likeButton.snp.bottom).offset(10)
        //                make.leading.equalTo(likeLabel.snp.trailing)
        //            }
        //        }
        //        else {
        //            likeLabel.snp.remakeConstraints { make in
        //                make.height.equalTo(0)
        //                make.top.equalTo(likeButton.snp.bottom).offset(10)
        //                make.leading.equalTo(likeButton.snp.leading)
        //            }
        //            likeCount.snp.remakeConstraints { make in
        //                make.height.equalTo(0)
        //                make.top.equalTo(likeButton.snp.bottom).offset(10)
        //                make.leading.equalTo(likeLabel.snp.trailing)
        //            }
        //        }
        //        likeCount.text = "님 외\(likeCountValue)명이 좋아합니다."
        //    }
        //
        //    @objc func messageButtonTapped() {
        //        let modalViewController = CommentModalViewController()
        //        modalViewController.post = self.post
        //        modalViewController.log = self.log
        //        self.present(modalViewController, animated: true)
        //    }
        //
        //    @objc func bookMarkButtonTapped() {
        //        bookMarkButton.isSelected.toggle()
        //        PostService.shared.scrapPost(postId: self.post!.postId){ _ in
        //
        //        }
        //    }
        //}
        //
        //extension UIButton {
        //    func setImage(systemName: String) {
        //        // 가로, 세로 정렬
        //        contentHorizontalAlignment = .fill
        //        contentVerticalAlignment = .fill
        //        // 이미지를 꽉차게 만듬
        //        imageView?.contentMode = .scaleAspectFit
        //        // 기존 setImage 메소드
        //        setImage(UIImage(systemName: systemName), for: .normal)
        //    }
        //}
        //
        //extension DetailPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        //
        //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        let page = Int(targetContentOffset.pointee.x / view.frame.width)
        //        self.pageControl.currentPage = page
        //    }
        //
        //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return imageUrls.count
        //    }
        //
        //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.id, for: indexPath)
        //        if let cell = cell as? PostCollectionViewCell {
        //            cell.postImageView.kf.setImage(with:URL(string: imageUrls[indexPath.row]))
        //        }
        //        return cell
        //    }
    }
}

extension DetailPostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        
    }
}

