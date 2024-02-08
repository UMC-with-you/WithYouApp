//
//  MyPageViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class MyPageViewController: UIViewController {
    
    let myPageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
//    let tabCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return collectionView
//    }()
//
//    let highlightView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        return view
//    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setCollectionView()
//        setTabBar()
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
        
//        highlightView.snp.makeConstraints { make in
//            make.width.equalTo(80)
//            make.height.equalTo(1)
//        }
        
        // 프로필
        myPageCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
        // 탭바
        myPageCollectionView.register(TabBarCollectionViewCell.self, forCellWithReuseIdentifier: TabBarCollectionViewCell.identifier)
        
        // 포스트
        myPageCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
//
//    func setTabBar() {
//        let firstIndexPath = IndexPath(item: 0, section: 0)
//        // delegate 호출
//        collectionView(myPageCollectionView, didSelectItemAt: firstIndexPath)
//        // cell select
//        myPageCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
//    }
    
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패")
            }
            return cell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == tabCollectionView {
//            guard let cell = tabCollectionView.cellForItem(at: indexPath) as? TabBarCollectionViewCell else {
//                NSLayoutConstraint.deactivate(constraints)
//                constraints = [
//                    highlightView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                    highlightView.widthAnchor.constraint(equalToConstant: 80)
//                ]
//                NSLayoutConstraint.activate(constraints)
//                return
//            }
//
//            NSLayoutConstraint.deactivate(constraints)
//            highlightView.translatesAutoresizingMaskIntoConstraints = false
//            constraints = [
//                highlightView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
//                highlightView.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
//            ]
//            NSLayoutConstraint.activate(constraints)
//
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//            tabPageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
//    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if scrollView == tabPageCollectionView {
//            let index = Int(targetContentOffset.pointee.x / tabPageCollectionView.frame.width)
//            let indexPath = IndexPath(item: index, section: 0)
//
//            tabCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
//            collectionView(tabCollectionView, didSelectItemAt: indexPath)
//
//            if direction > 0 {
//                // >>>> 스와이프하면 스크롤은 중앙으로
//                tabCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            } else {
//                // <<<< 스와이프하면 스크롤은 왼쪽으로
//                tabCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
//            }
//        }
//    }
    
//    // 스크롤 방향을 알아내기 위한 함수
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
//        
//        if velocity.x < 0 {
//            // -: 오른쪽에서 왼쪽 <<<
//            direction = -1
//        } else if velocity.x > 0 {
//            // +: 왼쪽에서 오른쪽 >>>
//            direction = 1
//        } else {
//            
//        }
//    }
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
