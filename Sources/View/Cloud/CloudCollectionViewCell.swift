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
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
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
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with image: UIImage) {
        postImageView.image = image
    }
}
