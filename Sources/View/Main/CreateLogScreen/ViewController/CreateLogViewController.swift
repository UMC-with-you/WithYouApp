//
//  CreateTravelLogViewController.swift
// WithYou
//
//  Created by 김도경 on 4/20/24.
//  Copyright © 2024Withyou.org. All rights reserved.
//

import SnapKit
import RxCocoa
import RxGesture
import UIKit

class CreateLogViewController: BaseViewController{
    let createLogView = CreateLogView()
    let viewModel = CreateLogViewModel()
    
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
        bindInput()
        bindOutput()
    }
    
    override func setLayout() {
        createLogView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setUp() {
        view.addSubview(createLogView)
    }
    
    override func setDelegate() {
        createLogView.titleTextField.delegate = self
    }
    
    private func bindInput(){
        createLogView.createTripButton
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { [weak self] event in
                self?.createTripButtonTapped()
            }
            .disposed(by: disposeBag)
        
        createLogView.fromDatePicker.rx
            .tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                print("Tapped")
            }
            .disposed(by: disposeBag)
        
        createLogView.titleTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.textFieldObservable)
            .disposed(by: disposeBag)
        
    }
    
    private func bindOutput(){
        viewModel.titleLength
            .emit { [weak self] count in
                self?.createLogView.characterCountLabel.text = count
            }
            .disposed(by: disposeBag)
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
    
    private func createTripButtonTapped() {
        if let tripTitle = createLogView.titleTextField.text, !tripTitle.isEmpty {
            guard let fromDate = createLogView.fromDatePicker.titleLabel?.text else {return }
            guard let toDate = createLogView.toDatePicker.titleLabel?.text else {return}
            // 서버에 보낼때 Log 구조체 형식으로 보내기에 필요한 데이터는 제외하고 Dummy Data 넣음
            // log.asRequest 메서드가 호출 되서 자동으로 필요한 데이터만 보냄
            let newLog = Log(id: 0, title: tripTitle, startDate: fromDate, endDate: toDate, status: "", imageUrl: "")
            guard let image = createLogView.bannerImageView.image else { return }
            self.viewModel.createLog(newLog, image: image)
            self.dismiss(animated: true)
        } else {
            print("텍스트 필드에 여행 제목을 입력하세요.")
        }
    }
    
    private func popDateSheet(){
        let sheet = DateSheetViewController()
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return UIScreen.main.bounds.height / 3.5
        }
        
        if let sheet = sheet.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        present(sheet, animated: true)
    }
}



// MARK: - UITextFieldDelegate
extension CreateLogViewController : UITextFieldDelegate {
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//   g
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 텍스트 필드가 편집을 시작할 때 호출되는 메서드
        textField.layer.cornerRadius = 8.0 // 둥근 테두리 반지름 설정
        textField.layer.borderWidth = 1.0 // 테두리 두께 설정
        textField.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = WithYouAsset.subColor.color.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Process of closing the Keyboard when the line feed button is pressed.
        textField.resignFirstResponder()
        return true
        
    }
}


// MARK: - UIImagePickerDelegate
//extension CreateLogViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            createLogView.bannerImageView.image = selectedImage
//            createLogView.selectImageButton.isHidden = true
//            createLogView.cancleImageButton.isHidden = false
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    // 이미지 선택 버튼의 액션 메서드
//    @objc func selectImage() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
//    }
//    
//    // 이미지 취소 버튼의 액션 메서드
//    @objc func cancleImage() {
//        createLogView.bannerImageView.image = UIImage()
//        createLogView.cancleImageButton.isHidden = true
//        createLogView.selectImageButton.isHidden = false
//    }
//    
//    // MARK: - UIDatePicker
//    @objc func showFromBottomSheet() {
//        self.view.endEditing(true)
//        dateType = .from
//        // bottomSheetVC가 nil이거나 해제되었는지 확인하고, 그 경우에만 새로운 인스턴스를 생성합니다.
//        if fromBottomSheetVC == nil || fromBottomSheetVC?.isViewLoaded == false {
//            fromBottomSheetVC = BottomSheetViewController()
//            fromBottomSheetVC?.delegate = self // 델리게이트 설정
//        }
//        
//        fromBottomSheetVC?.modalPresentationStyle = .overFullScreen
//        self.present(fromBottomSheetVC!, animated: false, completion: nil)
//    }
//    
//    @objc func showToBottomSheet() {
//        self.view.endEditing(true)
//        dateType = .to
//        // bottomSheetVC가 nil이거나 해제되었는지 확인하고, 그 경우에만 새로운 인스턴스를 생성합니다.
//        if toBottomSheetVC == nil || toBottomSheetVC?.isViewLoaded == false {
//            toBottomSheetVC = BottomSheetViewController()
//            toBottomSheetVC?.delegate = self // 델리게이트 설정
//        }
//        
//        toBottomSheetVC?.modalPresentationStyle = .overFullScreen
//        self.present(toBottomSheetVC!, animated: false, completion: nil)
//    }
//    
//    func didPickDate(_ date: Date) {
//        // 날짜를 선택한 후에 호출되는 메서드
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        
//        switch dateType {
//        case .from:
//            fromDatePicker.setTitle(dateFormatter.string(from: date), for: .normal)
//            fromDateLabel.textColor = WithYouAsset.mainColorDark.color
//            fromDatePicker.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
//        case .to:
//            toDatePicker.setTitle(dateFormatter.string(from: date), for: .normal)
//            toDateLabel.textColor = WithYouAsset.mainColorDark.color
//            toDatePicker.setTitleColor( WithYouAsset.mainColorDark.color, for: .normal)
//        }
//        
//        if fromDateLabel.textColor == WithYouAsset.mainColorDark.color && toDateLabel.textColor == WithYouAsset.mainColorDark.color {
//            datePickerContainer.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
//            //calendarIcon.image = UIImage(named: "CalendarIconDark")
//            calendarIcon.tintColor =WithYouAsset.mainColorDark.color
//            print("test")
//            didSetContext()
//        }
//    }
//    private func didSetContext(){
//        if titleTextField.hasText {
//            print("success")
//            createTripButton.backgroundColor = WithYouAsset.mainColorDark.color
//        }
//        else{
//            createTripButton.backgroundColor = WithYouAsset.subColor.color
//        }
//    }
//}
//
