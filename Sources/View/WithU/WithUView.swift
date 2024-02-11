//
//  WithUView.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class WithUView: UIView {

    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 32)
//        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "DAY 2"
        label.textColor = UIColor(named: "MainColorDark")
        label.textAlignment = .center
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "오징어들의 오사카 여행"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 0.96, alpha: 1)
        return view
    }()
    
    let noticeView = NoticeView()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
//        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "오늘 하루 기록하기"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let rewindView: UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.backgroundColor = UIColor(red: 0.96, green: 0.76, blue: 0.69, alpha: 1)
        let systemImage = UIImage(systemName: "book.closed")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "오늘의 여행 Rewind"
        view.subLabel.text = "오늘 여행은 어떠셨나요?\n오늘 하루 느꼈던 감정과 기억을\n기록하고, 함께 여행한\n사람들과 나눌 수 있어요!"
        view.mainImage.tintColor = .white
        
        return view
    }()
    
    let chatView: UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.backgroundColor = UIColor(red: 0.6, green: 0.58, blue: 0.74, alpha: 1)
        let systemImage = UIImage(systemName: "ellipsis.bubble")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "오늘의 한마디"
        view.subLabel.text = "함께 여행한 with You에게\n오늘 하루를 마치며 하고 싶은\n말을 전해주세요! 하루에\n딱 하나의 메시지를 보낼 수\n있어요!"
        view.mainImage.tintColor = .white
        return view
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 20
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(dayLabel)
        addSubview(noticeView)
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(underLine)
        
        setupStackView()
    
        setConstraints()
        self.bringSubviewToFront(mainLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        // 뷰컨트롤러의 기본뷰 위에 스택뷰 올리기
        self.addSubview(stackView)
        
        // 스택뷰 위에 뷰들 올리기
        stackView.addArrangedSubview(rewindView)
        stackView.addArrangedSubview(chatView)
    }

    private func setConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(15)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(15)
        }
        
        underLine.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.top).offset(15)
            make.leading.equalTo(mainLabel.snp.leading)
        }
        
        noticeView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(mainLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeView.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(15)
        }
        
        rewindView.snp.makeConstraints { make in
            make.width.height.equalTo(170)
        }

        chatView.snp.makeConstraints { make in
            make.width.height.equalTo(170)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
        }
    }
}
