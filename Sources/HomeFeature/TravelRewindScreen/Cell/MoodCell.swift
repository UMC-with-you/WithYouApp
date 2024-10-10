//
//  MoodCell.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import UIKit
import SnapKit

class MoodCell: UICollectionViewCell {

    static var reuseIdentifier: String { return String(describing: self) }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage?) {
        imageView.image = image
    }
}
