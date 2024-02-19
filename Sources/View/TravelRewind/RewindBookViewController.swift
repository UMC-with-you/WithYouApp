//
//  DetailPostViewController.swift
//  WithYou
//
//  Created by 배수호 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class RewindBookViewController: UIViewController, UITableViewDelegate {
    
    var dataSource2: [String?] = []
    var dataSource3: [String?] = []
    var dataSource4: [String?] = []
    
    var todayMoodImages: [UIImageView?] = []
    
    var likeCountValue:Int = 0
    var totalHeight: CGFloat = 150
    
    private func setupDataSource() {
        for i in 1...4 {
            dataSource2.append("테스트 중입니다~~~~~~~~~~~~~\(i)")
        }
        for i in 1...2 {
            dataSource3.append("가나다라마바사아자차카타파하\(i)")
        }
        
        
        dataSource4.append("1111212121212121212121221212testtestsetstetsetsteteststsetestsettsetsetestestestestesteststsetteestestestesteststsetteestestestesteststsetteestttestetstestsetsetestsetsetsetses")
        
        todayMoodImages.append(UIImageView(image: WithYouAsset.sad.image))
        todayMoodImages.append(UIImageView(image: WithYouAsset.angry.image))
        todayMoodImages.append(UIImageView(image: WithYouAsset.heart.image))
        todayMoodImages.append(UIImageView(image: WithYouAsset.sunny.image))
    
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오징어들의 오사카여행"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "chevron.left")
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "chevron.right")
        return button
    }()
    
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.16 - 2023.11.20"
        label.font = WithYouFontFamily.Pretendard.light.font(size: 12)
        label.textColor = WithYouAsset.logoColor.color
        
        return label
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = WithYouAsset.subColor.color
        return view
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
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 14)
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
    
    
    let question2Label: UILabel = {
        let label = UILabel()
        label.text = "#2. 오늘 여행에서 가장 기억에 남는 순간은?"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var question2TableView:UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let question3Label: UILabel = {
        let label = UILabel()
        label.text = "#3. 오늘 여행에서 조금 아쉬웠던 점이 있을까요?"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var question3TableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        question2TableView.dataSource = self
        question2TableView.delegate = self
        question3TableView.dataSource = self
        question3TableView.delegate = self
        
        question2TableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: "AnswerCell")
        question3TableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: "AnswerCell")

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
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        contentView.addSubview(periodLabel)
        contentView.addSubview(divider)
        contentView.addSubview(dayLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(todaysMoodLabel)
        var temp: UIImageView = todayMoodImages[0]!
        for i in todayMoodImages {
            contentView.addSubview(i!)
            i!.snp.makeConstraints { make in
                make.top.equalTo(todaysMoodLabel.snp.bottom).offset(5)
                make.width.height.equalTo(37)
                if i == temp{
                    make.trailing.equalTo(todaysMoodLabel.snp.trailing)
                }
                else{
                    make.trailing.equalTo(temp.snp.leading).offset(13)
                    temp = i!
                }
            }
        }
        
        contentView.addSubview(question1Label)
        contentView.addSubview(mvpImageView)
        contentView.addSubview(mvpNameLabel)
        contentView.addSubview(question2Label)
        contentView.addSubview(question2TableView)
        contentView.addSubview(question3Label)
        contentView.addSubview(question3TableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-20)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(titleLabel)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(periodLabel.snp.bottom).offset(25)
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
            make.leading.trailing.equalTo(dayLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
        }
        
        mvpImageView.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel).offset(10)
            make.top.equalTo(question1Label.snp.bottom).offset(10)
            make.width.height.equalTo(70)
        }
        
        mvpNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(mvpImageView)
            make.top.equalTo(mvpImageView.snp.bottom).offset(5)
        }
        
        question2Label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(dayLabel)
            make.top.equalTo(mvpNameLabel.snp.bottom).offset(20)
        }
        
        question2TableView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.leading.equalTo(dayLabel)
            make.height.equalTo(70*dataSource2.count)
            print("\(totalHeight) tableView make Constraints ")// 총합을 적용
            make.top.equalTo(question2Label.snp.bottom).offset(20)
        }
        
        //
        question3Label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(dayLabel)
            make.top.equalTo(question2TableView.snp.bottom).offset(20)
            
        }
        
        question3TableView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.leading.equalTo(dayLabel)
            make.top.equalTo(question3Label.snp.bottom).offset(20)
            make.height.equalTo(70*dataSource3.count)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        //
        //                   // contentView의 높이를 동적으로 계산하여 설정
        
        contentView.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentView.frame.height)
    }
}
extension RewindBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == question2TableView {
            // question2TableView의 경우에는 dataSource2.count 반환
            return dataSource2.count
        } else if tableView == question3TableView {
            // question3TableView의 경우에는 dataSource3.count 반환
            return dataSource3.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == question2TableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerTableViewCell
            cell.configure(with: dataSource2[indexPath.row], image: WithYouAsset.testProfile.image, name: "경주")
            cell.backgroundColor = WithYouAsset.backgroundColor.color
            return cell
        } else if tableView == question3TableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerTableViewCell
            cell.configure(with: dataSource3[indexPath.row], image: WithYouAsset.testProfile.image, name: "유빈")
            cell.backgroundColor = WithYouAsset.backgroundColor.color
            return cell
        }
        // 기본적으로 빈 셀을 반환합니다. 필요에 따라 다른 동작을 추가할 수 있습니다.
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

