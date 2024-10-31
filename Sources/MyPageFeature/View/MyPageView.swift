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
    
    let profileView = ProfileView(size: .my)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행초보"
        label.textColor = UIColor(red: 0.85, green: 0.7, blue: 0.28, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 11)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor(red: 0.85, green: 0.7, blue: 0.28, alpha: 1).cgColor
        return label
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Medium", size: 20)
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
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
        label.text = "My"
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
            $0.top.equalTo(profileView.snp.top).offset(5)
            $0.leading.equalTo(profileView.snp.trailing).offset(10)
            $0.width.equalTo(55)
            $0.height.equalTo(20)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.equalTo(profileView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.equalTo(85)
            $0.height.equalTo(30)
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
