//
//  AddPostViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import RxCocoa
import RxGesture
import RxSwift
import PhotosUI
import UIKit

class AddPostViewController: UIViewController {
    
    let titleLabel = {
        let label = UILabel()
        label.text = "POST"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        return label
    }()
    
    let topContainerView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    
    let travelTitle = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .center
        return label
    }()
    
    let dateTitle = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = WithYouAsset.backgroundColor.color
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .gray.withAlphaComponent(0.2)
        collectionView.register(PostThumbCollectionViewCell.self, forCellWithReuseIdentifier: PostThumbCollectionViewCell.cellId)
        return collectionView
    }()
    
    let textField = {
        let field = UITextField()
        field.placeholder = "내용을 작성해주세요..."
        field.textColor = WithYouAsset.mainColorDark.color
        field.font = WithYouFontFamily.Pretendard.light.font(size: 15)
        field.textAlignment = .natural
        field.contentVerticalAlignment = .top
        return field
    }()
    
    lazy var photoPicker = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 7
        configuration.selection = .ordered
        configuration.preselectedAssetIdentifiers = selectedAssetIdentifiers
        let picker = PHPickerViewController(configuration: configuration)
        return picker
    }()
    private var selections = [String : PHPickerResult]()
    private var selectedAssetIdentifiers = [String]()
    
    var images = [UIImage]()
    var content = ""
    var rxImages = PublishSubject<[UIImage]>()
    var log : Log?
    
    var addImageButton = WYAddButton(.small)
    
    var addButton = WYButton("업로드")
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConst()
        setConfiguration()
        setRx()
    }
    
    private func setRx(){
        //PHPicker 띄우기
        addImageButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                self.present(self.photoPicker,animated: true)
            }
            .disposed(by: bag )
        
        //Post 업로드
        addButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
//                let newPost = NewPostStruct(text: self.textField.text ?? "", mediaList: self.images)
//                PostService.shared.addPost(travelId: self.log!.id, newPost: newPost){response in
//                    var myPosts = DataManager.shared.getMyPost()
////                    myPosts.append(LocalPostDTO(postId: response.postId, travelId: self.log!.id))
////                    DataManager.shared.setMyPost(myPosts: myPosts)
//                    self.navigationController?.popViewController(animated: true)
//                }
            }
            .disposed(by: bag)
        
        rxImages.bind(to: imageCollectionView.rx.items(cellIdentifier: PostThumbCollectionViewCell.cellId, cellType: PostThumbCollectionViewCell.self)){ index, item, cell in
            cell.thumb.image = item
            cell.makeConst()
        }
        .disposed(by: bag)
        
        imageCollectionView.rx
            .modelSelected(UIImage.self)
            .subscribe{ image in
                self.present(self.photoPicker,animated: true)
        }
        .disposed(by: bag)
        
    }

    private func setConfiguration(){
        //네비바 설정
        self.navigationItem.titleView = titleLabel
        view.backgroundColor = .white
        
        //델리게이트 설정
        photoPicker.delegate = self
        textField.delegate = self
        
        //텍스트 입력시 뷰 올라가게만들기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    private func setConst(){
        topContainerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        travelTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        dateTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(travelTitle.snp.bottom).offset(5)
        }
        imageCollectionView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.top.equalTo(topContainerView.snp.bottom)
        }
        textField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(15)
            $0.bottom.equalTo(addButton.snp.top).offset(15)
        }
        
        addImageButton.snp.makeConstraints{
            $0.center.equalTo(imageCollectionView)
        }
        
        addButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
    }
    
    private func setUp(){
        [topContainerView, imageCollectionView,textField, addImageButton,addButton].forEach{
            view.addSubview($0)
        }
        [travelTitle,dateTitle].forEach{
            topContainerView.addSubview($0)
        }
    }
    
    func bindData(log:Log){
        self.log = log
        travelTitle.text = log.title
        dateTitle.text = "\(log.startDate.replacingOccurrences(of: "-", with: ".")) - \(log.endDate.replacingOccurrences(of: "-", with: "."))"
        
    }
}

// MARK: PHPickerDelegate
extension AddPostViewController : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.images = []
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                self.images.append(image)
                self.rxImages.onNext(self.images)
            }
        }
        picker.dismiss(animated: true){
            self.addImageButton.isHidden = true
        }
    }
}

// MARK: TextFieldDelegate
extension AddPostViewController: UITextFieldDelegate{
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.hasText {
            self.content = textField.text!
            addButton.backgroundColor = WithYouAsset.mainColorDark.color
        } else {
            addButton.backgroundColor = WithYouAsset.subColor.color
        }
        return true
    }
    
    // 텍스트 필드의 편집이 종료될 때 호출되는 메서드
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing")
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
