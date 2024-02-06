    //
//  DetailPostViewController.swift
//  WithYou
//
//  Created by 배수호 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class DetailPostViewController: UIViewController {
    
    var dataSource: [String] = []
    var likeCountValue:Int = 3
    
    private func setupDataSource() {
        for i in 0...8 {
            dataSource += ["\(i)"]
        }
    }

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
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
 
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = dataSource.count
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        pageControl.pageIndicatorTintColor = WithYouAsset.subColor.color
        pageControl.currentPageIndicatorTintColor = .black
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
        label.text = "이번 여행도 재밌었다!!"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        setUI()
    }
    
    private func setUI(){
        view.backgroundColor = WithYouAsset.backgroundColor.color
        view.addSubview(titleLabel)
        view.addSubview(periodLabel)
        view.addSubview(postCollectionView)
        view.addSubview(pageControl)
        view.addSubview(likeButton)
        view.addSubview(messageButton)
        view.addSubview(bookMarkButton)
        view.addSubview(likeLabel)
        view.addSubview(likeCount)
        view.addSubview(contextLabel)
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.id)

        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
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
            
            //            make.leading.equalTo(messageButton.snp.trailing).offset(10)
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
            make.width.equalToSuperview().offset(-30)
        }
        
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
        let modalViewController = ModalViewController()
        self.present(modalViewController, animated: true)
    }
    
    @objc func bookMarkButtonTapped() {
        bookMarkButton.isSelected.toggle()
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
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.id, for: indexPath)
        if let cell = cell as? PostCollectionViewCell {
            cell.model = dataSource[indexPath.item]
        }

        return cell
    }
}

extension DetailPostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        
    }
}
