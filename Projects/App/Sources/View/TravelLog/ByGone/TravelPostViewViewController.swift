//
//  TravelPostViewViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxGesture
import SnapKit
import UIKit

class TravelPostViewViewController : UIViewController{
    let titleLabel = {
        let label = UILabel()
        label.text = "POST"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        return label
    }()
    
    let topContainerView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    
    let travelTitle = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .center
        return label
    }()
    
    let dateTitle = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3) - 2 , height: (UIScreen.main.bounds.width/3) - 2)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let grid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        grid.register(PostThumbCollectionViewCell.self, forCellWithReuseIdentifier: PostThumbCollectionViewCell.cellId)
        grid.showsVerticalScrollIndicator = false
        grid.backgroundColor = .white
        return grid
    }()
    
    let addButton = WYAddButton(.big)
    
    var log : Log?
    
    var post = BehaviorRelay<[Post]>(value: [])
     
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = titleLabel
        
        setUp()
        setConst()
        configureRefreshControl()
        setRx()
        loadPosts()
    }
    
    private func setRx(){
        // Cell 할당
        post.bind(to: collectionView.rx.items(cellIdentifier: PostThumbCollectionViewCell.cellId, cellType: PostThumbCollectionViewCell.self)){ index, item, cell in
            cell.bind(imageUrl: item.thumbnailUrl)
        }
        .disposed(by:bag)
        
        //Cell 클릭시
        collectionView.rx.modelSelected(Post.self)
            .subscribe{ post in
                let newVC = DetailPostViewController()
                newVC.bind(post: post, log: self.log!)
                self.navigationController?.pushViewController(newVC, animated: true)
            }
            .disposed(by: bag)
        
        //addbutton 클릭시
        addButton
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                let nextVC = AddPostViewController()
                nextVC.bindData(log: self.log!)
                nextVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: bag)
        
    }
    
    public func bindLog(log:Log){
        self.log = log
        travelTitle.text = log.title
        dateTitle.text = "\(log.startDate.replacingOccurrences(of: "-", with: ".")) - \(log.endDate.replacingOccurrences(of: "-", with: "."))"
        
        loadPosts()
    }
    
    private func loadPosts(){
        PostService.shared.getAllPost(travelId: self.log!.id){ posts in
            self.post.accept(posts)
        }
    }
    
    // 당겨서 새로고침
    func configureRefreshControl () {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
                                                    #selector(handleRefreshControl),
                                                 for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        loadPosts()
        DispatchQueue.main.async{
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func setConst(){
        topContainerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        travelTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        dateTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(travelTitle.snp.bottom).offset(5)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(topContainerView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        addButton.snp.makeConstraints{
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        view.bringSubviewToFront(addButton)
    }
    
    private func setUp(){
        [topContainerView,collectionView,addButton].forEach{
            view.addSubview($0)
        }
        [travelTitle,dateTitle].forEach {
            topContainerView.addSubview($0)
        }
    }
}
