//
//  CloudCollectionViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/14.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

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
    
}
