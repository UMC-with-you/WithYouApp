//
//  CreateTravelRewindView.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//
import UIKit
import SnapKit
import Foundation

public class CreateTravelRewindView: BaseUIView {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 32)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 20)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let todaysMoodLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 기분"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 14)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let moodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(named: "SubColor")?.cgColor
        imageView.layer.cornerRadius = 9.0
        return imageView
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton()
        
        if let originalImage = UIImage(systemName: "plus.circle.fill") {
            let tintedColor = UIColor(named: "SubColor") ?? .blue
            let tintedImage = originalImage.withTintColor(tintedColor, renderingMode: .alwaysOriginal)
            let newSize = CGSize(width: 26, height: 26)
            let resizedImage = UIGraphicsImageRenderer(size: newSize).image { _ in
                tintedImage.draw(in: CGRect(origin: .zero, size: newSize))
            }
            button.setImage(resizedImage, for: .normal)
        }
        button.backgroundColor = .clear
        return button
    }()
    
    let question1Label : UILabel = {
        let label = UILabel()
        label.text = "#1. 오늘 여행의 MVP"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 26
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: 70, height: 85)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        view.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.id)
        return view
    }()
    let question2Label = UILabel()
    let question2TextField = WYTextField()
    let question3Label = UILabel()
    let question3TextField = WYTextField()
    let question4Label = UILabel()
    let question4TextField = WYTextField()
    let question5Label = UILabel()
    let question5TextField = WYTextField()
    let addButton = WYButton("저장하기")

    public override func initUI() {
        // Create an array of all subviews
        
        let subviews = [
            dayLabel, titleLabel, todaysMoodLabel, moodImageView, selectImageButton,
            question1Label, collectionView, question2Label, question2TextField,
            question3Label, question3TextField, question4Label, question4TextField,
            question5Label, question5TextField, addButton
        ]
        
        // Add subviews using forEach
        subviews.forEach { self.addSubview($0) }
        
        [question2TextField, question3TextField, question4TextField, question5TextField].forEach{
            $0.placeholder = "내용을 입력해주세요"
        }
        [question1Label,question2Label,question3Label,question4Label,question5Label].forEach{
            $0.font = WithYouFontFamily.Pretendard.medium.font(size: 14)
            $0.textColor = UIColor(named: "MainColorDark")
        }
    }
    
    public override func initLayout() {
        
        dayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel.snp.leading)
        }
        
        addUnderline(to: titleLabel, thickness: 7, color: UIColor(named: "UnderlineColor") ?? .black)
        
        self.bringSubviewToFront(titleLabel)
        
        todaysMoodLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.top).offset(5)
            make.trailing.equalToSuperview().inset(15)
        }
        
        moodImageView.snp.makeConstraints { make in
            make.centerX.equalTo(todaysMoodLabel)
            make.top.equalTo(todaysMoodLabel.snp.bottom).offset(8)
            make.width.equalTo(todaysMoodLabel.snp.width).multipliedBy(0.75)
            make.height.equalTo(moodImageView.snp.width)
        }
        
        selectImageButton.snp.makeConstraints { make in
            make.center.equalTo(moodImageView.snp.center)
        }
        
        question1Label.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(question1Label.snp.bottom)
            make.leading.equalTo(dayLabel.snp.leading)
            make.trailing.equalTo(todaysMoodLabel.snp.trailing)
            make.height.equalTo(collectionView.snp.width).multipliedBy(0.34)
        }

        question2Label.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
        }
        
        question2TextField.snp.makeConstraints { make in
            make.top.equalTo(question2Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(todaysMoodLabel)
            make.height.equalTo(49)
        }
        
        question3Label.snp.makeConstraints { make in
            make.top.equalTo(question2TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(collectionView.snp.trailing)
        }
        
        question3TextField.snp.makeConstraints {make in
            make.top.equalTo(question3Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(todaysMoodLabel)
            make.height.equalTo(50)
        }
        
        question4Label.snp.makeConstraints { make in
            make.top.equalTo(question3TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(todaysMoodLabel)
            make.trailing.equalTo(collectionView.snp.trailing)
        }
        
        question4TextField.snp.makeConstraints {make in
            make.top.equalTo(question4Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(todaysMoodLabel)
            make.height.equalTo(50)
        }
        
        question5Label.snp.makeConstraints { make in
            make.top.equalTo(question4TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalToSuperview().offset(15)
        }
        
        question5TextField.snp.makeConstraints {make in
            make.top.equalTo(question5Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(todaysMoodLabel)
            make.height.equalTo(50)
        }
        addButton.snp.makeConstraints{
            $0.width.equalTo(question5TextField)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.top.equalTo(question5TextField.snp.bottom).offset(20)
        }
    }
}
