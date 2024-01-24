import UIKit
import SnapKit

enum DateType{
    case from
    case to
}

class CreateTravelLogViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BottomSheetDelegate {
    
    var fromBottomSheetVC: BottomSheetViewController?
    var toBottomSheetVC: BottomSheetViewController?
    var dateType: DateType = .from
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 제목"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        return textField
    }()
    
    let characterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = UIFont(name: "Pretendard-Regular", size: 12.0)
        label.textAlignment = .right
        return label
    }()
    
    let travelPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 기간"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let fromDateLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        return label
    }()
    
    //    let fromDatePicker: UIDatePicker = {
    //        let datePicker = UIDatePicker()
    //        datePicker.datePickerMode = .date
    //        datePicker.locale = Locale(identifier: "ko_KR")
    //        return datePicker
    //    }()
    
    
    let fromDatePicker: UIButton = {
        let button = UIButton()
        // 현재 날짜를 가져와서 포맷팅
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // 날짜 포맷을 필요에 맞게 설정
        
        // 포맷팅된 날짜를 버튼의 타이틀로 설정
        button.setTitle(dateFormatter.string(from: currentDate), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    let toDateLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        return label
    }()
    
    //    let toDatePicker: UIDatePicker = {
    //        let datePicker = UIDatePicker()
    //        datePicker.datePickerMode = .date
    //        datePicker.locale = Locale(identifier: "ko_KR")
    //        return datePicker
    //    }()
    let toDatePicker: UIButton = {
        let button = UIButton()
        // 현재 날짜를 가져와서 포맷팅
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // 날짜 포맷을 필요에 맞게 설정
        
        // 포맷팅된 날짜를 버튼의 타이틀로 설정
        button.setTitle(dateFormatter.string(from: currentDate), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    let bannerLabel: UILabel = {
        let label = UILabel()
        label.text = "배너 사진"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(named: "SubColor")?.cgColor
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
            button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        }
        button.backgroundColor = .clear
        
        return button
    }()
    
    let cancleImageButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(cancleImage), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let createTripButton: UIButton = {
        let button = UIButton()
        button.setTitle("여행 만들기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "SubColor")
        button.titleLabel?.font =  UIFont(name: "Pretendard-SemiBold", size: 16.0)
        button.layer.cornerRadius = 16.0 // 원하는 라운드 값으로 설정
        button.layer.masksToBounds = true // 라운드 적용을 위해 마스크 사용
        button.addTarget(self, action: #selector(createTripButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        titleTextField.delegate = self
        
        setupUI()
        
        // fromDatePicker 버튼이 클릭되었을 때 Bottom Sheet를 표시하는 액션 추가
        fromDatePicker.addTarget(self, action: #selector(showFromBottomSheet), for: .touchUpInside)
        toDatePicker.addTarget(self, action: #selector(showToBottomSheet), for: .touchUpInside)
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(characterCountLabel)
        view.addSubview(travelPeriodLabel)
        view.addSubview(fromDateLabel)
        view.addSubview(fromDatePicker)
        view.addSubview(toDateLabel)
        view.addSubview(toDatePicker)
        view.addSubview(bannerLabel)
        view.addSubview(bannerImageView)
        view.addSubview(selectImageButton)
        view.addSubview(cancleImageButton)
        view.addSubview(createTripButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalToSuperview().offset(50)
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
        
        fromDateLabel.snp.makeConstraints { make in
            make.top.equalTo(travelPeriodLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview().offset(-70)
        }
        
        fromDatePicker.snp.makeConstraints { make in
            make.top.equalTo(fromDateLabel.snp.bottom).offset(5)
            make.centerX.equalTo(fromDateLabel)
        }
        
        toDateLabel.snp.makeConstraints { make in
            make.top.equalTo(travelPeriodLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview().offset(70)
        }
        
        toDatePicker.snp.makeConstraints { make in
            make.top.equalTo(toDateLabel.snp.bottom).offset(5)
            make.centerX.equalTo(toDateLabel)
        }
        
        bannerLabel.snp.makeConstraints { make in
            make.top.equalTo(toDatePicker.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints{ make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(bannerImageView.snp.width).multipliedBy(1.25)
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
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(createTripButton.snp.width).multipliedBy(0.11)
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let characterCount = newText.count
        
        if characterCount <= 20 {
            characterCountLabel.text = "\(characterCount)/20"
            return true
        } else {
            return false
        }
    }
    
    @objc func createTripButtonTapped() {
        if let tripTitle = titleTextField.text, !tripTitle.isEmpty {
            print("여행 제목: \(tripTitle)")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            //            let fromDate = dateFormatter.string(from: fromDatePicker.date)
            //            let toDate = dateFormatter.string(from: toDatePicker.date)
            //
            //            print("From: \(fromDate), To: \(toDate)")
        } else {
            print("텍스트 필드에 여행 제목을 입력하세요.")
        }
    }
    
    // 이미지 선택 버튼의 액션 메서드
    @objc func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            bannerImageView.image = selectedImage
            selectImageButton.isHidden = true
            cancleImageButton.isHidden = false
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 취소 버튼의 액션 메서드
    
    @objc func cancleImage() {
        bannerImageView.image = UIImage()
        cancleImageButton.isHidden = true
        selectImageButton.isHidden = false
    }
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 텍스트 필드가 편집을 시작할 때 호출되는 메서드
        textField.layer.cornerRadius = 8.0 // 둥근 테두리 반지름 설정
        textField.layer.borderWidth = 1.0 // 테두리 두께 설정
        textField.layer.borderColor = UIColor(named: "MainColor")?.cgColor // 테두리 색상 설정
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 텍스트 필드의 편집이 종료될 때 호출되는 메서드
        print("End Editing")
        
    }
    
    @objc func showFromBottomSheet() {
        dateType = .from
        // bottomSheetVC가 nil이거나 해제되었는지 확인하고, 그 경우에만 새로운 인스턴스를 생성합니다.
        if fromBottomSheetVC == nil || fromBottomSheetVC?.isViewLoaded == false {
            fromBottomSheetVC = BottomSheetViewController()
            fromBottomSheetVC?.delegate = self // 델리게이트 설정
        }

        fromBottomSheetVC?.modalPresentationStyle = .overFullScreen
        self.present(fromBottomSheetVC!, animated: false, completion: nil)
    }
    
    @objc func showToBottomSheet() {
        dateType = .to
        // bottomSheetVC가 nil이거나 해제되었는지 확인하고, 그 경우에만 새로운 인스턴스를 생성합니다.
        if toBottomSheetVC == nil || toBottomSheetVC?.isViewLoaded == false {
            toBottomSheetVC = BottomSheetViewController()
            toBottomSheetVC?.delegate = self // 델리게이트 설정
        }

        toBottomSheetVC?.modalPresentationStyle = .overFullScreen
        self.present(toBottomSheetVC!, animated: false, completion: nil)
    }
    
    
    
    func didPickDate(_ date: Date) {
        // 날짜를 선택한 후에 호출되는 메서드
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        switch dateType {
        case .from:
            fromDatePicker.setTitle(dateFormatter.string(from: date), for: .normal)
        case .to:
            toDatePicker.setTitle(dateFormatter.string(from: date), for: .normal)
        }
    }
    
}
