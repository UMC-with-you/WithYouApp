//
//  PostCollectionViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/05.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class PostGridCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostGridCollectionViewCell"
    
//    lazy var backColor: [UIColor] = [.lightGray, .purple, .orange, .cyan, .magenta]
    
//    func setColor(index: Int){
//        self.backgroundColor = backColor[index]
//    }
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "LaunchImage")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setCell()
        self.setupPageViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setCell() {
        self.backgroundColor = .lightGray
        self.addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.top)
            make.bottom.equalTo(postImageView.snp.bottom)
            make.leading.equalTo(postImageView.snp.leading)
            make.trailing.equalTo(postImageView.snp.trailing)
        }
    }
        
    private func setupPageViewController() {
        // 페이지 뷰 컨트롤러 초기화 및 설정
        // 페이지 뷰 컨트롤러에 표시할 뷰 컨트롤러들을 추가하고 초기 뷰 컨트롤러 설정
    }
    
    public func setupData() {
        // 이미지뷰 이미지를 업로드하기
    }
}
//
//extension PostCollectionViewCell: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
////        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil }
////        let previousIndex = index - 1
////        if previousIndex < 0 {
////            return nil
////        }
////        return dataSourceVC[previousIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
////        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil }
////        let nextIndex = index + 1
////        if nextIndex == dataSourceVC.count {
////            return nil
////        }
////        return dataSourceVC[nextIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
////        guard let currentVC = pageViewController.viewControllers?.first,
////              let currentIndex = dataSourceVC.firstIndex(of: currentVC) else { return }
////        currentPage = currentIndex
////        print(currentIndex)
//    }
//}
