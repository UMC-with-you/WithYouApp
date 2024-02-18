//
//  MyPageViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxGesture
import UIKit
import SnapKit

final class MyPageViewController: UIViewController {
    
    let myPageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setCollectionView()
    }
    
    private func setCollectionView() {
        myPageCollectionView.delegate = self
        myPageCollectionView.dataSource = self
        
        view.addSubview(myPageCollectionView)
        
        myPageCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
        }
        
        // 프로필
        myPageCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        // 탭바
        myPageCollectionView.register(TabBarCollectionViewCell.self, forCellWithReuseIdentifier: TabBarCollectionViewCell.identifier)
        
        // 포스트
        myPageCollectionView.register(PostGridCollectionViewCell.self, forCellWithReuseIdentifier: PostGridCollectionViewCell.identifier)
    }
    
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    // cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 24
//            return userPosts?.count ?? 0
        }
    }
    
    // cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패")
            }
            cell.navigationController = self.navigationController
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostGridCollectionViewCell.identifier, for: indexPath) as? PostGridCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패")
            }
            return cell
        }
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: CGFloat(160))
        default:
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
            return CGSize(width: side, height: side)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
}
