//
//  NameProfileViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/30.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import UIKit
import RxSwift
import SnapKit

/// 회원가입 세번째 화면
class NameProfileViewController: UIViewController {
    
    private let colorPalette: [UIColor] = [
        WithYouAsset.nameBackgroundColorRed.color,
        WithYouAsset.nameBackgroundColorOrange.color,
        WithYouAsset.nameBackgroundColorYellow.color,
        WithYouAsset.nameBackgroundColorGreen.color,
        WithYouAsset.nameBackgroundColorBlue.color,
        WithYouAsset.nameBackgroundColorPurple.color,
        WithYouAsset.nameBackgroundColorPink.color,
        WithYouAsset.nameBackgroundColorGray.color
    ]
    
    var nickName: String?
    var newImage : PublishSubject<UIImage> = PublishSubject()
    var selectedBackgroundColor: UIColor?
    
    weak var coordinator: ProfileSettingCoordinator?
    
    private let disposeBag = DisposeBag()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "배경 색상을 선택하세요"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    /// 배경색을 가진 이미지
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = WithYouAsset.subColor.color.cgColor
        imageView.layer.cornerRadius = 100
        imageView.backgroundColor = .red
        return imageView
    }()
    
    /// 배경에 추가될 닉네임
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 48)
        return label
    }()
    
    lazy var colorScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var colorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalSpacing
        return stack
    }()
    
    /// 색상 투명도 조절 슬라이더 (실제 투명도는 1.0으로 유지하면서 더 밝은 색상으로 변환)
    lazy var colorSlider: ColorSlider = {
        let colorSlider = ColorSlider(color: colorPalette[0])
        colorSlider.translatesAutoresizingMaskIntoConstraints = false
        return colorSlider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setViews()
        setConstraints()
        bind()
        if let nickName = nickName {
            textLabel.text = nickName
        }
    }
    
    private func setViews() {
        view.addSubview(mainLabel)
        view.addSubview(profileImageView)
        view.addSubview(colorScrollView)
        view.addSubview(colorSlider)
     
        profileImageView.addSubview(textLabel)
        colorScrollView.addSubview(colorStackView)
        setupColorPalette()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        let button = WYButton("완료")
        button.backgroundColor = WithYouAsset.mainColorDark.color
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 30)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-200)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        colorScrollView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(CGFloat(550).adjustedH)
            $0.width.equalTo(CGFloat(361).adjusted)
            $0.height.equalTo(CGFloat(40).adjustedH)
        }
        
        colorStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        colorSlider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(CGFloat(590).adjustedH)
            $0.width.equalTo(CGFloat(361).adjusted)
            $0.height.equalTo(CGFloat(80).adjustedH)
        }
        
    }
    
    private func setupColorPalette() {
        for color in colorPalette {
            let button = UIButton()
            button.backgroundColor = color
            button.layer.cornerRadius = 20
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 1
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(CGFloat(40).adjustedH)
            }
            
            button.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.profileImageView.backgroundColor = color
                    self?.selectedBackgroundColor = color
                    self?.colorSlider.colorChanged(color: color)
                })
                .disposed(by: disposeBag)
            
            colorStackView.addArrangedSubview(button)
        }
    }

    /// 컬러슬라이더 Rx
    private func bind() {
        colorSlider.colorObservable
            .observe(on: MainScheduler.instance)
            .bind(to: Binder(self) { vc, color in
                vc.profileImageView.backgroundColor = color
                vc.selectedBackgroundColor = color
            })
            .disposed(by: disposeBag)
    }
    
    @objc func doneButtonTapped() {
        // 닉네임 이미지로 만들어서 보내기
        //newImage.onNext(self.profileImageView.asImage())
        newImage.onCompleted()
        //        self.navigationController?.popViewController(animated: true)
        
        coordinator?.finishProfileSetting()
    }
    
    @objc func profileImageTapped() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true, completion: nil)
    }
}

extension NameProfileViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        selectedBackgroundColor = viewController.selectedColor
        profileImageView.backgroundColor = selectedBackgroundColor
    }
}
