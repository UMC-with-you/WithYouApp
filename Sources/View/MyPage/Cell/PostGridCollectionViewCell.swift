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
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "LaunchImage")
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
        self.addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
}
