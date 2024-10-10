//
//  AddPostViewController.swift
//  WithYou
//
//  Created by bryan on 9/20/24.
//

import RxSwift
import PhotosUI

public protocol AddPostViewControllerDelgate {
    func showPhotoPicker(_ viewController : PHPickerViewControllerDelegate)
    func dismissView()
}

class AddPostViewController: BaseViewController {
    
    private let addPostView = AddPostView()
    
    private let viewModel : AddPostViewModel
    
    public var coordinator : AddPostViewControllerDelgate?
    
    var content = ""
    var rxImages = PublishSubject<[UIImage]>()
    
    
    init(viewModel : AddPostViewModel){
        self.viewModel = viewModel
        super.init()
    }
    
    override func setUp() {
        view.addSubview(addPostView)
    }
    
    override func setLayout() {
        addPostView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    override func setFunc() {
        //PHPicker 띄우기
        addPostView.addImageButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe{ (owner,_) in
                owner.coordinator?.showPhotoPicker(owner)
            }
            .disposed(by: disposeBag )
        
        //Post 업로드
        addPostView.addButton.rx
            .tap
            .withUnretained(self)
            .subscribe{ (owner, _) in
                if owner.viewModel.buttonStatus.value {
                    if let text = owner.addPostView.textField.text {
                        owner.viewModel.addPost(text)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedImages.bind(to: addPostView.imageCollectionView.rx.items(cellIdentifier: AddPostPhotoCell.cellId, cellType: AddPostPhotoCell.self)){ index, item, cell in
            cell.thumb.image = item
            cell.makeConst()
        }
        .disposed(by: disposeBag)
        
        addPostView.imageCollectionView
            .rx
            .modelSelected(UIImage.self)
            .withUnretained(self)
            .subscribe{ (owner, _) in
                owner.coordinator?.showPhotoPicker(owner)
            }
        .disposed(by: disposeBag)
        
        viewModel.buttonStatus
            .map{ $0 ? WithYouAsset.mainColorDark.color : WithYouAsset.subColor.color}
            .bind(to: addPostView.addButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.finished
            .subscribe(onNext: { finish in
                if finish {
                    self.coordinator?.dismissView()
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    override func setUpViewProperty() {
        //네비바 설정
        self.navigationItem.titleView = addPostView.titleLabel
        view.backgroundColor = .white
        
        //텍스트 입력시 뷰 올라가게만들기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bindData()
        
    }
    
    override func setDelegate() {
        //델리게이트 설정
        addPostView.textField.delegate = self
    }

    
    func bindData(){
        addPostView.travelTitle.text = viewModel.log.title
        addPostView.dateTitle.text = "\(viewModel.log.startDate.replacingOccurrences(of: "-", with: ".")) - \(viewModel.log.endDate.replacingOccurrences(of: "-", with: "."))"
        
    }
}

// MARK: PHPickerDelegate
extension AddPostViewController : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        var imageArray = [UIImage]()
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                imageArray.append(image)
            }
        }
        picker.dismiss(animated: true){
            self.addPostView.addImageButton.isHidden = true
            self.viewModel.checkStatus()
            self.viewModel.setImages(imageArray)
        }
    }
}

// MARK: TextFieldDelegate
extension AddPostViewController: UITextFieldDelegate{
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 필드의 편집이 종료될 때 호출되는 메서드
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count != 0 {
                viewModel.isTextEmpty = false
            } else {
                viewModel.isTextEmpty = true
            }
        }
        self.viewModel.checkStatus()
    }
    
    // return button 눌렀을 떄
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyBoardHeight = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyBoardHeight.cgRectValue.height
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
