//
//  PostDetailViewController.swift
//  TravelLogFeature
//
//  Created by bryan on 8/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

class DetailPostViewController: BaseViewController {
    
    private let postView = PostDetailView()
    
    private let navLabel = {
        let label = UILabel()
        label.text = "Post"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        return label
    }()
    
    private let viewModel : PostDetailViewModel
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPosts()
    }
    
    override func setFunc() {
        viewModel.post
            .subscribe(onNext: { post in
                self.bindPost(post)
            })
            .disposed(by: disposeBag)
        viewModel.post
            .bind(to: postView.postCollectionView.rx.items(cellIdentifier: <#T##String#>, cellType: <#T##Cell.Type#>))
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
    
    private func bindPost(_ post : Post){
        postView.titleLabel.text = viewModel.log.title
        postView.periodLabel.text = "\(viewModel.log.startDate) - \(viewModel.log.endDate)"
        //CollectionView

    }
}
