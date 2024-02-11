//
//  TabBarCollectionViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/06.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class TabBarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabBarCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 17)
        label.textColor = UIColor.lightGray
        return label
    }()
        
    override var isSelected: Bool {
        didSet {
            let textColor = isSelected ? UIColor(named: "MainColorDark") : .lightGray
            titleLabel.textColor = textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func getTitleFrameWidth() -> CGFloat {
        self.titleLabel.frame.width
    }
    
    func configureCell(title: String) {
        titleLabel.text = title
    }
    
}

