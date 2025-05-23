//
//  MyPageView.swift
//  WithYou
//
//  Created by 이승진 on 10/14/24.
//

import UIKit
import SnapKit

class MyPageView: BaseUIView {
    
    // UI Components
    let topLabel = UILabel()
    
    let myPageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 1, height: UIScreen.main.bounds.width / 3 - 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let profileView = {
        let profileView = ProfileView(size: .my)
        profileView.profileImage.image = ProfileUserDefaultManager.profileImage
        return profileView
    }()
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행초보"
        label.textColor = UIColor(red: 0.85, green: 0.7, blue: 0.28, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 12
        label.layer.borderColor = UIColor(red: 0.85, green: 0.7, blue: 0.28, alpha: 1).cgColor
        return label
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = WithYouAsset.logoColor.color
        label.text = ProfileUserDefaultManager.userName
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Medium", size: 21)
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(WithYouAsset.mypageTintColor.color, for: .normal)
        button.titleLabel?.font = WithYouFontFamily.Pretendard.medium.font(size: 17)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.layer.borderColor = WithYouAsset.mypageTintColor.color.cgColor
        return button
    }()
    
    /* SegmentControl로 변경 필요 */
    let scrapLabel: UILabel = {
        let label = UILabel()
        label.text = "SCRAP"
        label.textColor = UIColor(named: "MainColorDark")
        label.font = UIFont(name: "Pretendard-Medium", size: 18)
        return label
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MainColorDark")
        return view
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.text = "MY"
        label.textColor = .lightGray
        label.font = UIFont(name: "Pretendard-Medium", size: 18)
        return label
    }()
    
    var underLineConst: Constraint?
    
    override func initUI() {
        [profileView, titleLabel, nickNameLabel, editButton, scrapLabel, myLabel, underlineView, myPageCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func initLayout() {
        profileView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.top).offset(2)
            $0.leading.equalTo(profileView.snp.trailing).offset(13)
            $0.width.equalTo(67)
            $0.height.equalTo(25)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel.snp.leading).offset(5)
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.equalTo(profileView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.equalTo(106)
            $0.height.equalTo(34)
        }
        
        scrapLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(100)
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(60)
        }
        
        myLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-120)
            $0.centerY.equalTo(scrapLabel)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(scrapLabel.snp.bottom).offset(1)
            self.underLineConst = $0.centerX.equalTo(scrapLabel.snp.centerX).constraint
            $0.height.equalTo(3)
            $0.width.equalTo(scrapLabel.snp.width)
        }
        
        myPageCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(underlineView.snp.bottom).offset(2)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up UI properties
    private func setUpViewProperty() {
        self.backgroundColor = .white
        topLabel.text = "MY"
        topLabel.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        topLabel.textAlignment = .center
        topLabel.textColor = WithYouAsset.mainColorDark.color
    }
}
