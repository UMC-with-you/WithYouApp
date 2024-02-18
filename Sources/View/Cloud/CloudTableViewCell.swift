//
//  CloudTableViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/14.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit
import PhotosUI

class CloudTableViewCell: UITableViewCell {
    static let identifier = "CloudTableViewCell"
//    static let cellHeight = 100.0
    
    // 이미지 선택 결과 저장
    private var selections = [String: PHPickerResult]()
    
    // 선택한 이미지의 identifier 배열
    private var selectedAssetIdentifiers = [String]()
    
    private let gridFlowLayout: GridCollectionViewFlowLayout = {
        let layout = GridCollectionViewFlowLayout()
//        layout.cellSpacing = 1
//        layout.numberOfColumns = 4
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "DAY 1"
        label.textColor = UIColor(named: "PointColor")
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "11월 16일"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.gridFlowLayout)
        view.isScrollEnabled = true
        view.register(CloudCollectionViewCell.self, forCellWithReuseIdentifier: "CloudCollectionViewCell")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.backgroundColor = .blue
    
        setViews()
        setConstraints()
        updateCollectionViewHeight()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(collectionView)
    }
    
    func setConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(dayLabel.snp.trailing).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
            make.height.equalTo(collectionView.contentSize.height)
            make.width.equalToSuperview()
        }
    }
    
    func updateCollectionViewHeight() {
            collectionView.layoutIfNeeded()
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(collectionView.contentSize.height)
            }
        
            setNeedsUpdateConstraints()
        }
    
    func configure(with selections: [String: PHPickerResult], _ selectedAssetIdentifiers: [String]) {
           self.selections = selections
           self.selectedAssetIdentifiers = selectedAssetIdentifiers
           collectionView.reloadData()
       }

}

extension CloudTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //    self.items.count
        return selectedAssetIdentifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CloudCollectionViewCell.identifier, for: indexPath) as! CloudCollectionViewCell
        let identifier = selectedAssetIdentifiers[indexPath.item]
            if let result = selections[identifier] {
                let itemProvider = result.itemProvider
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            cell.configure(with: image)
                        }
                    }
                }
            }
        return cell
    }
}

extension CloudTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard
            let flowLayout = collectionViewLayout as? GridCollectionViewFlowLayout,
            flowLayout.numberOfColumns > 0
        else { fatalError() }
//
//        let widthOfCells = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
//        let widthOfSpacing = CGFloat(flowLayout.numberOfColumns - 1) * flowLayout.cellSpacing
//        let width = floor((widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns))
        let width = floor(collectionView.bounds.width / 4) - 4
        return CGSize(width: width, height: width)
    }
}


