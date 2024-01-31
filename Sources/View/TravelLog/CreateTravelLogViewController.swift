
import UIKit
import SnapKit


enum DateType{
    case from
    case to
}

class CreateTravelLogViewController: UIViewController, BottomSheetDelegate{
        
    let API = travelsAPI()
    
    
    var fromBottomSheetVC: BottomSheetViewController?
    var toBottomSheetVC: BottomSheetViewController?
    var dateType: DateType = .from
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 제목"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .left
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        return textField
    }()
    
    let characterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
        label.textAlignment = .right
        return label
    }()
    
    let travelPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "여행 기간"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .left
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    let fromDateLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 13)
        label.textColor = WithYouAsset.subColor.color
        return label
    }()
    
    let fromDatePicker: UIButton = {
        let button = UIButton()
        // 포맷팅된 날짜를 버튼의 타이틀로 설정
        let currentDate = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy.MM.dd"
        button.titleLabel?.font = WithYouFontFamily.Pretendard.medium.font(size: 18)
        button.setTitleColor(WithYouAsset.subColor.color, for: .normal)
        // 포맷팅된 날짜를 버튼의 타이틀로 설정
        button.setTitle(dateFormatter.string(from: currentDate), for: .normal)
        return button
    }()
    
    lazy var calendarIcon = UIImageView(image: UIImage(named: "CalendarIcon"))
    
    let toDateLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 13)
        label.textColor = WithYouAsset.subColor.color
        return label
    }()
    
    let toDatePicker = {
        let button = UIButton()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // 날짜 포맷을 필요에 맞게 설정
        
        button.setTitle(dateFormatter.string(from: currentDate), for: .normal)
       
        button.titleLabel?.font = WithYouFontFamily.Pretendard.medium.font(size: 18)
        button.setTitleColor(WithYouAsset.subColor.color, for: .normal)
        return button
    }()
    
    //도경: 앱 디자인과 유사하게 바꾸기 위해 구조 변경함
    let datePickerContainer = {
        let container = UIView()
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.borderColor = WithYouAsset.subColor.color.cgColor
        return container
    }()
    
    let bannerLabel: UILabel = {
        let label = UILabel()
        label.text = "배너 사진"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        label.textAlignment = .left
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = WithYouAsset.subColor.color.cgColor
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
        let button = WYButton("여행 만들기")
        button.addTarget(self, action: #selector(createTripButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Navigation시 Tabbar 없이 전체화면으로
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        
        setupUI()
        setConst()
        
        // fromDatePicker 버튼이 클릭되었을 때 Bottom Sheet를 표시하는 액션 추가
        fromDatePicker.addTarget(self, action: #selector(showFromBottomSheet), for: .touchUpInside)

        toDatePicker.addTarget(self, action: #selector(showToBottomSheet), for: .touchUpInside)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(characterCountLabel)
        view.addSubview(travelPeriodLabel)
        view.addSubview(datePickerContainer)
        [fromDateLabel,fromDatePicker,toDateLabel,toDatePicker,calendarIcon].forEach{
            datePickerContainer.addSubview($0)
        }
        view.addSubview(bannerLabel)
        view.addSubview(bannerImageView)
        view.addSubview(selectImageButton)
        view.addSubview(cancleImageButton)
        view.addSubview(createTripButton)
    }
    
    func setConst(){
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(createTripButton.snp.width).multipliedBy(0.11)
        }
    }
    
    // MARK: - Functions
    // 캘린더 bottom sheet
//    @objc func showBottomSheet() {
//        let bottomSheetVC = BottomSheetViewController()
//        // 1
//        bottomSheetVC.modalPresentationStyle = .overFullScreen
//        // 2
//        self.present(bottomSheetVC, animated: false, completion: nil)
//    }
    
    @objc func createTripButtonTapped() {
        if let tripTitle = titleTextField.text, !tripTitle.isEmpty {
            print("여행 제목: \(tripTitle)")
            API.travelsAPI()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        } else {
            print("텍스트 필드에 여행 제목을 입력하세요.")
        }
    }
}


// 도경 : Delegate 관련 extension으로 빼고 함수 정렬
extension CreateTravelLogViewController : UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 텍스트 필드가 편집을 시작할 때 호출되는 메서드
        textField.layer.cornerRadius = 8.0 // 둥근 테두리 반지름 설정
        textField.layer.borderWidth = 1.0 // 테두리 두께 설정
        textField.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Process of closing the Keyboard when the line feed button is pressed.
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIImagePickerDelegate
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
    
    // 이미지 선택 버튼의 액션 메서드
    @objc func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 이미지 취소 버튼의 액션 메서드
    @objc func cancleImage() {
        bannerImageView.image = UIImage()
        cancleImageButton.isHidden = true
        selectImageButton.isHidden = false
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
            fromDateLabel.textColor = WithYouAsset.mainColorDark.color
            fromDatePicker.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
        case .to:
            toDatePicker.setTitle(dateFormatter.string(from: date), for: .normal)
            toDateLabel.textColor = WithYouAsset.mainColorDark.color
            toDatePicker.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
        }
        
        if fromDateLabel.textColor == WithYouAsset.mainColorDark.color && toDateLabel.textColor == WithYouAsset.mainColorDark.color {
            datePickerContainer.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
            calendarIcon.image = UIImage(named: "CalendarIconDark")
            print("test")
        }
    }
    

}



