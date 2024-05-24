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

private enum DateType {
    case from
    case to
}

class CreateLogViewController: BaseViewController{
    let createLogView = CreateLogView()
    let viewModel = CreateLogViewModel()
    
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
    
    override func setFunc(){
        //CreateButton Color State
        viewModel
            .isDataFilled
            .subscribe { [weak self] isDataFilled in
                self?.createLogView.toggleCreateButton(isDataFilled)
            }
            .disposed(by: disposeBag)
        
        createLogView.createTripButton
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { [weak self] event in
                self?.createTripButtonTapped()
            }
            .disposed(by: disposeBag)
        
        //이미지 선택창 열기
        createLogView.selectImageButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.showImagePicker()
            }
            .disposed(by: disposeBag)
        
        //선택한 이미지 삭제
        createLogView.cancleImageButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.cancleImage()
            }
            .disposed(by: disposeBag)
        
        //
        createLogView.fromDatePicker
            .rx
            .tap
            .subscribe{ [weak self] _ in
                self?.showDateSheet(.from)
            }
            .disposed(by: disposeBag)
        
        createLogView.toDatePicker
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.showDateSheet(.to)
            })
            .disposed(by: disposeBag)
    }
}

// VC Functions
extension CreateLogViewController {
    
    private func createTripButtonTapped() {
        viewModel.createLog()
    }
    
    private func showDateSheet(_ dateType : DateType){
        let sheet = DateSheetViewController()
        sheet.datePicker.minimumDate = dateController.strToDate(self.createLogView.fromDatePicker.titleLabel?.text ?? Date().toString())
        
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return UIScreen.main.bounds.height / 2.2
        }
        
        if let sheet = sheet.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
  
        sheet.dateObservable
            .subscribe { [weak self] event in
                switch event {
                case .next(let date):
                    self?.dateDidPicked(dateType, date: date)
                case .error(_):
                    break
                case .completed:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        present(sheet, animated: true)
    }
    
    private func dateDidPicked(_ dateType : DateType , date : Date){
        switch dateType {
        case .from:
            self.createLogView.fromDatePicker.setTitle(dateController.dateToStr(date), for: .normal)
            self.createLogView.fromDatePicker.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
            self.createLogView.fromDateLabel.textColor = WithYouAsset.mainColorDark.color
            self.viewModel.fromDate = date
        case .to:
            self.createLogView.toDatePicker.setTitle(dateController.dateToStr(date), for: .normal)
            self.createLogView.toDatePicker.setTitleColor(WithYouAsset.mainColorDark.color, for: .normal)
            self.createLogView.toDateLabel.textColor = WithYouAsset.mainColorDark.color
            self.viewModel.toDate = date
        }
        
        if createLogView.toDateLabel.textColor == WithYouAsset.mainColorDark.color &&
            createLogView.toDateLabel.textColor == WithYouAsset.mainColorDark.color {
            createLogView.calendarIcon.tintColor = WithYouAsset.mainColorDark.color
        }
        //Check if all data is Filled
        self.viewModel.checkData()
    }
    
    private func showImagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func cancleImage() {
        createLogView.bannerImageView.image = UIImage()
        createLogView.cancleImageButton.isHidden = true
        createLogView.selectImageButton.isHidden = false
        viewModel.image = nil
    }
}

// MARK: - UITextFieldDelegate
extension CreateLogViewController : UITextFieldDelegate {
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 텍스트 필드가 편집을 시작할 때 호출되는 메서드
        textField.layer.cornerRadius = 8.0 // 둥근 테두리 반지름 설정
        textField.layer.borderWidth = 1.0 // 테두리 두께 설정
        textField.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = WithYouAsset.subColor.color.cgColor
        self.viewModel.checkData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Process of closing the Keyboard when the line feed button is pressed.
        textField.resignFirstResponder()
        return true
    }
    
    // 텍스트 필드 글자 수 제한 및 Title 저장
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let characterCount = newText.count
        
        if characterCount <= 20 {
            viewModel.title = newText
            createLogView.characterCountLabel.text = "\(characterCount)/20"
            return true
        } else {
            return false
        }
        
    }
}

// MARK: - 이미지 선택 처리
extension CreateLogViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            createLogView.bannerImageView.image = selectedImage
            createLogView.selectImageButton.isHidden = true
            createLogView.cancleImageButton.isHidden = false
            viewModel.image = selectedImage
        }
        //Check if all data is filled
        self.viewModel.checkData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
