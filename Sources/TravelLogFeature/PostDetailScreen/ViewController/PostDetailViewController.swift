//
//  PostDetailViewController.swift
//  TravelLogFeature
//
//  Created by bryan on 8/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public protocol DetailPostViewControllerDelgate{
    func openCommentSheet(_ post : Post)
}

class DetailPostViewController: BaseViewController {
    
    private let navLabel = {
        let label = UILabel()
        label.text = "Post"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        return label
    }()
    
    private let postView = PostDetailView()
    
    private let viewModel : PostDetailViewModel
    
    public var coordinator : DetailPostViewControllerDelgate?
    
    private var post : Post?
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPosts()
        self.postView.pageControl.numberOfPages = post!.images.count
        self.postView.pageControl.currentPage = 0
    }
    
    override func setFunc() {
        
//        //키보드 팝업시 화면 올라감
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        viewModel.post
            .subscribe(onNext: { post in
                self.post = post
                self.bindPost(post)
                self.viewModel.bindImages(post.images)
            })
            .disposed(by: disposeBag)
        
        viewModel.postImages
            .bind(to:postView.postCollectionView.rx.items(cellIdentifier: PostImageCell.cellId, cellType: PostImageCell.self)){ index, item, cell in
                cell.configure(with: item.imageUrl)
            }
            .disposed(by: disposeBag)
        
        //Comment Button
        postView.commentButton
            .rx
            .tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (owner,_) in
                owner.coordinator?.openCommentSheet(self.post!)
            }
            .disposed(by: disposeBag)
  
        postView.pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
    }
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
        self.navigationItem.titleView = navLabel
    }
    
    override func setUp() {
        view.addSubview(postView)
    }
    
    override func setLayout() {
        postView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setDelegate() {
        self.postView.postCollectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindPost(_ post : Post){
        postView.titleLabel.text = viewModel.log.title
        postView.periodLabel.text = "\(viewModel.log.startDate) - \(viewModel.log.endDate)"
        //CollectionView
        postView.contextLabel.text = post.text
    }
}

extension DetailPostViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate the current page based on the scroll offset
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        
        // Update the page control's current page
        self.postView.pageControl.currentPage = Int(pageIndex)
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let offset = CGPoint(x: view.frame.width * CGFloat(page), y: 0)
        self.postView.postCollectionView.setContentOffset(offset, animated: true)
    }
}
