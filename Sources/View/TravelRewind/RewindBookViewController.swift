//
//  DetailPostViewController.swift
//  WithYou
//
//  Created by 배수호 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class RewindBookViewController: UIViewController {
    
    var dataSource: [UIImage?] = []
    var likeCountValue:Int = 0
    
    private func setupDataSource() {
        for i in 1...5 {
            dataSource.append(UIImage(named:"post\(i)"))
        }
        print(dataSource)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오징어들의 오사카여행"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.16 - 2023.11.20"
        label.font = WithYouFontFamily.Pretendard.light.font(size: 12)
        label.textColor = WithYouAsset.gray2.color
        
        return label
    }()
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "DAY 2"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 32.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.17"
        label.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        label.textAlignment = .left
        label.textColor = WithYouAsset.gray2.color
        return label
    }()
    
    let todaysMoodLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 기분"
        label.font = UIFont(name: "Pretendard-Semibold", size: 14.0)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let question1Label: UILabel = {
        let label = UILabel()
        label.text = "#1. 오늘 여행의 MVP"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mvpImageView: UIImageView = {
        let imageView = UIImageView(image: WithYouAsset.testProfile.image)
        return imageView
    }()
    
    lazy var mvpNameLabel: UILabel = {
        let label = UILabel()
        label.text = "영주"
        label.textColor = WithYouAsset.mainColorDark.color
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        setUI()
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        view.backgroundColor = WithYouAsset.backgroundColor.color
        contentView.addSubview(titleLabel)
        contentView.addSubview(periodLabel)
        contentView.addSubview(dayLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(todaysMoodLabel)
        contentView.addSubview(question1Label)
        contentView.addSubview(mvpImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(titleLabel)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(periodLabel.snp.bottom).offset(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom)
            make.leading.equalTo(dayLabel.snp.leading)
        }
        
        todaysMoodLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayLabel.snp.centerY)
            make.trailing.equalTo(dayLabel.snp.trailing).offset(-10)
        }
        
        question1Label.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.leading)
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
        }
        
        contentView.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentView.frame.height)
    }
    
}


