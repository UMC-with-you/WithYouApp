//
//  PostImageCell.swift
//  WithYou
//
//  Created by bryan on 9/19/24.
//

import Foundation
import Kingfisher
import UIKit

class PostImageCell : UICollectionViewCell{
    static let cellId = "PostImageCell"
    
    // ImageView to display the post image
        var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            setupLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.addSubview(imageView)
        }
        
        private func setupLayout() {
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview() // Image takes up the entire cell
            }
        }
        
        // Method to configure the cell with image data
        func configure(with imageUrl: String) {
            // Here you can load the image using a library like SDWebImage or URLSession
            // For example, using SDWebImage:
            //imageView.kf.setImage(with: imageUrl)'
            imageView.image = WithYouAsset.logModel0.image
        }
}
