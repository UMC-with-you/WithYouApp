//
//  CloudCollectionViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/14.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit
import PhotosUI

class CloudCollectionViewCell: UICollectionViewCell {
    static let identifier = "CloudCollectionViewCell"
    
    //    let scrollView: UIScrollView = {
    //        let scrollView = UIScrollView()
    //        scrollView.showsVerticalScrollIndicator = true
    //        scrollView.alwaysBounceVertical = true
    //        return scrollView
    //    }()
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        //        image.image = UIImage(named: "LaunchImage")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setCell() {
        self.backgroundColor = .lightGray
        contentView.addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            //            make.top.equalTo(postImageView.snp.top)
            //            make.bottom.equalTo(postImageView.snp.bottom)
            //            make.leading.equalTo(postImageView.snp.leading)
            //            make.trailing.equalTo(postImageView.snp.trailing)
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with image: UIImage) {
        postImageView.image = image
    }
    
//    func setImage(_ image: UIImage) {
//        postImageView.image = image
//    }
//    func processImage(_ image: UIImage) {
//        postImageView.image = image
//    }
//    func configure(with selections: [String : PHPickerResult], _ selectedAssetIdentifiers: [String]) {
//            // 전달받은 데이터를 사용하여 UI 업데이트 등의 작업 수행
//            // 예: 이미지 뷰에 이미지 설정
//            if let firstIdentifier = selectedAssetIdentifiers.first,
//               let result = selections[firstIdentifier] {
//                // itemProvider를 통해 이미지 가져오기
//                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
//                    guard let image = image as? UIImage else { return }
//                    DispatchQueue.main.async {
//                        // 이미지 뷰에 이미지 설정
//                        self?.postImageView.image = image
//                    }
//                }
//            }
//        }
    
}
