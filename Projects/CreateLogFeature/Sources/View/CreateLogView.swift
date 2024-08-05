//
//  CreateLogView.swift
//   WithYou
//
//  Created by 김도경 on 4/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//
import Core
import CommonUI
import UIKit
class CreateLogView : BaseUIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 제목"
        label.font =  WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .left
        label.textColor =  WithYouAsset.mainColorDark.color
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font =  WithYouFontFamily.Pretendard.regular.font(size: 16)
        return textField
    }()
    
    let characterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font =  WithYouFontFamily.Pretendard.regular.font(size: 12)
        label.textAlignment = .right
        return label
    }()
    
    let travelPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 기간"
        label.font =  WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .left
        label.textColor =  WithYouAsset.mainColorDark.color
        return label
    }()
    
    let fromDateLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.font =  WithYouFontFamily.Pretendard.regular.font(size: 13)
        label.textColor =  WithYouAsset.subColor.color
        return label
    }()
    
    let fromDatePicker: UIButton = {
        let button = UIButton()
        // 포맷팅된 날짜를 버튼의 타이틀로 설정
        let currentDate = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy.MM.dd"
        button.titleLabel?.font =  WithYouFontFamily.Pretendard.medium.font(size: 18)
        button.setTitleColor( WithYouAsset.subColor.color, for: .normal)
        // 포맷팅된 날짜를 버튼의 타이틀로 설정
        button.setTitle(dateFormatter.string(from: currentDate), for: .normal)
        return button
    }()
    
    lazy var calendarIcon = {
        let imageView = UIImageView(image: UIImage(named: "CalendarIcon")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor =  WithYouAsset.subColor.color
        return imageView
    }()
    
    let toDateLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.font =  WithYouFontFamily.Pretendard.regular.font(size: 13)
        label.textColor =  WithYouAsset.subColor.color
        return label
    }()
    
    let toDatePicker = {
        let button = UIButton()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // 날짜 포맷을 필요에 맞게 설정
        
        button.setTitle(dateFormatter.string(from: currentDate), for: .normal)
       
        button.titleLabel?.font =  WithYouFontFamily.Pretendard.medium.font(size: 18)
        button.setTitleColor( WithYouAsset.subColor.color, for: .normal)
        return button
    }()
    
    //도경: 앱 디자인과 유사하게 바꾸기 위해 구조 변경함
    let datePickerContainer = {
        let container = UIView()
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.borderColor =  WithYouAsset.subColor.color.cgColor
        return container
    }()
    
    let bannerLabel: UILabel = {
        let label = UILabel()
        label.text = "배너 사진"
        label.font =  WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .left
        label.textColor =  WithYouAsset.mainColorDark.color
        return label
    }()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor =  WithYouAsset.subColor.color.cgColor
        imageView.layer.cornerRadius = 5.0 // 원하는 라운드 값으로 수정
        return imageView
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton()
        
        if let originalImage = UIImage(systemName: "plus.circle.fill") {
            // 원하는 색상으로 이미지 채색
            let tintedColor = UIColor(named: "SubColor") ?? .blue
            let tintedImage = originalImage.withTintColor(tintedColor, renderingMode: .alwaysOriginal)
            
            // 크기 조절
            let newSize = CGSize(width: 50, height: 50)
            let resizedImage = UIGraphicsImageRenderer(size: newSize).image { _ in
                tintedImage.draw(in: CGRect(origin: .zero, size: newSize))
            }
            
            button.setImage(resizedImage, for: .normal)
        }
        button.backgroundColor = .clear
        
        return button
    }()
    
    let cancleImageButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let createTripButton: UIButton = {
        let button = WYButton("여행 만들기")
        return button
    }()
    
    
    override func initUI() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(titleTextField)
        self.addSubview(characterCountLabel)
        self.addSubview(travelPeriodLabel)
        self.addSubview(datePickerContainer)
        [fromDateLabel,fromDatePicker,toDateLabel,toDatePicker,calendarIcon].forEach{
            datePickerContainer.addSubview($0)
        }
        self.addSubview(bannerLabel)
        self.addSubview(bannerImageView)
        self.addSubview(selectImageButton)
        self.addSubview(cancleImageButton)
        self.addSubview(createTripButton)
    }
    
    override func initLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(45)
        }
        
        characterCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(5)
            make.right.equalTo(titleTextField)
        }
        
        travelPeriodLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(characterCountLabel.snp.bottom).offset(5)
        }
        
        datePickerContainer.snp.makeConstraints{
            $0.top.equalTo(travelPeriodLabel.snp.bottom).offset(15)
            $0.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField.snp.height)
            $0.centerX.equalToSuperview()
        }
        
        calendarIcon.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        fromDateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalTo(calendarIcon.snp.trailing).offset(20)
        }
        fromDatePicker.snp.makeConstraints{
            $0.top.equalTo(fromDateLabel.snp.bottom)
            $0.leading.equalTo(fromDateLabel)
            $0.height.equalTo(15)
        }
        
        toDateLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-110)
        }
        toDatePicker.snp.makeConstraints{
            $0.top.equalTo(toDateLabel.snp.bottom)
            $0.leading.equalTo(toDateLabel)
            $0.height.equalTo(15)
        }
        
        bannerLabel.snp.makeConstraints { make in
            make.top.equalTo(datePickerContainer.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints{ make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalTo(createTripButton.snp.top).offset(-30)
        }
        
        selectImageButton.snp.makeConstraints { make in
            make.center.equalTo(bannerImageView)
        }
        
        cancleImageButton.snp.makeConstraints { make in
            make.centerX.equalTo(bannerImageView.snp.right)
            make.centerY.equalTo(bannerImageView.snp.top)
        }
        
        createTripButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(40)
        }
    }
    
    //Change CreateButton State
    public func toggleCreateButton(_ isDataFilled : Bool){
        if isDataFilled {
            createTripButton.backgroundColor = WithYouAsset.mainColorDark.color
        } else {
            createTripButton.backgroundColor = WithYouAsset.subColor.color
        }
    }
}
