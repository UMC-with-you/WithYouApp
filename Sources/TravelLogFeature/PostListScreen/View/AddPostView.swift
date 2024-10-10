//
//  AddPostView.swift
//  WithYou
//
//  Created by bryan on 9/20/24.
//

import Foundation
import PhotosUI

public final class AddPostView : BaseUIView {
    let titleLabel = {
        let label = UILabel()
        label.text = "POST"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
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
        collectionView.register(AddPostPhotoCell.self, forCellWithReuseIdentifier: AddPostPhotoCell.cellId)
        collectionView.isPagingEnabled = true
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
    
    var addImageButton = WYAddButton(.small)
    
    var addButton = WYButton("업로드")
    
    public override func initUI(){
        [topContainerView, imageCollectionView,textField, addImageButton,addButton].forEach{
            self.addSubview($0)
        }
        [travelTitle,dateTitle].forEach{
            topContainerView.addSubview($0)
        }
    }
    
    public override func initLayout() {
        topContainerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
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
            $0.bottom.equalToSuperview().inset(50)
        }
        
        addImageButton.snp.makeConstraints{
            $0.center.equalTo(imageCollectionView)
        }
        
        addButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
    }
}
