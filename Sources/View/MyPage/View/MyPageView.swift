//
//  MyPageView.swift
//  WithYou
//
//  Created by 김도경 on 3/21/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit

class MyPageView: UIView {
    
    let topLabel = {
        let label = UILabel()
        label.text = "MY"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .center
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
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
        let view = ProfileView(size: .my)
        //view.profileImage.image = UIImage(data:DataManager.shared.getUserImage())
        return view
    }()
    
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
        label.text = DataManager.shared.getUserName()
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
        button.titleLabel?.font = UIFont.systemFont(ofSize:13)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 10
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
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
    
    var underLineConst : Constraint?
    
    init(){
        super.init(frame: .zero)
        setUp()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        [profileView,titleLabel,nickNameLabel,editButton,scrapLabel, myLabel,underlineView,myPageCollectionView].forEach{
            self.addSubview($0)
        }
    }
    
    
    func setLayout(){
        profileView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(profileView.snp.top).offset(5)
            $0.leading.equalTo(profileView.snp.trailing).offset(10)
            $0.width.equalTo(55)
            $0.height.equalTo(20)
        }
        
        nickNameLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }

        editButton.snp.makeConstraints{
            $0.centerY.equalTo(profileView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.equalTo(85)
            $0.height.equalTo(30)
        }
        
        scrapLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(100)
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(60)
        }
        
        myLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-120)
            $0.centerY.equalTo(scrapLabel)
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(scrapLabel.snp.bottom).offset(1)
            self.underLineConst = $0.centerX.equalTo(scrapLabel.snp.centerX).constraint
            $0.height.equalTo(3)
            $0.width.equalTo(scrapLabel.snp.width)
        }
        myPageCollectionView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalTo(underlineView.snp.bottom).offset(2)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func bind(){
        //프로파일 이미지
        //사용자 이름
        //스크랩 된 포스트
        //내가 올린 포스트
    }
}
