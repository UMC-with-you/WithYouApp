//
//  ProfileCollectionViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/05.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    var navigationController: UINavigationController?
    
    let profileView = {
        let view = ProfileView(size: .small)
        view.profileImage.image = UIImage(data:DataManager.shared.getUserImage())
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
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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
    
    var bag = DisposeBag()
    var labelConst : Constraint?
    var myViewGridData = PublishSubject<[Post]>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setViews()
        self.setConstraints()
    }
    
    private func setRx(){
        scrapLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ [weak self]_ in
                self?.scrapLabel.tintColor = WithYouAsset.mainColorDark.color
                self?.myLabel.tintColor = .lightGray
                self?.scrapPosts()
                self?.labelConst?.deactivate()
                self?.underlineView.snp.makeConstraints{
                    self?.labelConst = $0.centerX.equalTo(self?.scrapLabel.snp.centerX ?? 0).constraint
                }
            }
            .disposed(by: bag)
        
        myLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ [weak self] _ in
                self?.scrapLabel.tintColor = .lightGray
                self?.myLabel.tintColor = WithYouAsset.mainColorDark.color
                self?.myPosts()
                self?.labelConst?.deactivate()
                self?.underlineView.snp.makeConstraints{
                    self?.labelConst = $0.centerX.equalTo(self?.myLabel.snp.centerX ?? 0).constraint
                }
            }
            .disposed(by: bag)
    }
    
    private func scrapPosts(){
        PostService.shared.getScrapedPost{ response in
            self.myViewGridData.onNext(response)
        }
    }
    
    private func myPosts(){
        var localPost = DataManager.shared.getMyPost()
        var newPosts = [Post]()
        for post in localPost{
            PostService.shared.getOnePost(postId: post.postId, travelId: post.travelId){ response in
                newPosts.append(Post(postId: response.postId, thumbnailUrl: response.postMediaDTO.first!.url))
            }
        }
        self.myViewGridData.onNext(newPosts)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setViews() {
        self.addSubview(profileView)
        self.addSubview(stackView)
        self.addSubview(editButton)

        [titleLabel, nickNameLabel].forEach{
            self.stackView.addArrangedSubview($0)
        }
        
        self.addSubview(scrapLabel)
        self.addSubview(myLabel)
        self.addSubview(underlineView)
    }
    
    private func setConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(15)
        }

        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(20)
        }

        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.leading.equalTo(profileView.snp.trailing).offset(20)
        }

        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(85)
            make.height.equalTo(30)
        }
        scrapLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(100)
            make.top.equalTo(profileView.snp.bottom).offset(45)
        }
        
        myLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-120)
            make.centerY.equalTo(scrapLabel)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(scrapLabel.snp.bottom).offset(1)
            labelConst = make.centerX.equalTo(scrapLabel.snp.centerX).constraint
            make.height.equalTo(3)
        }
    }
    
    @objc func editButtonTapped() {
        if let navController = self.navigationController {
            let profileEditController = ProfileEditViewController()
            navController.pushViewController(profileEditController, animated: true)
        }
    }
}

