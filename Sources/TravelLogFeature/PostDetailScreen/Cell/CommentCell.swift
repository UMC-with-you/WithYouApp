//
//  CommentCell.swift
//  WithYou
//
//  Created by bryan on 9/19/24.
//

import Foundation

import UIKit
import Kingfisher
import RxSwift
import SnapKit

class CommentCell: UICollectionReusableView {
    
    public static let cellId = "CommentCell"
    
    public let disposeBag = DisposeBag()

    lazy var profileImageView = ProfileView(size: .small)
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 12)
        label.textColor = .black
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = .black

        label.numberOfLines = 0
        return label
    }()
    
    lazy var replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("답글 달기", for: .normal)
        button.titleLabel?.font = WithYouFontFamily.Pretendard.regular.font(size: 10)
        button.setTitleColor(.gray, for: .normal)
        return button
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
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(replyButton)
    }
    
    private func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel)
        }
        
        replyButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom)
            make.leading.equalTo(nameLabel)
        }
    }
    
    // Configure the cell with comment data
    func configure(_ comment : Comment) {
        // Use a library like Kingfisher or SDWebImage to load profile image
        //profileImageView.image.kf.setImage(with: URL(string: profileImageUrl))
        nameLabel.text = "멤버\(comment.memberId)"
        commentLabel.text = comment.content
    }
}
