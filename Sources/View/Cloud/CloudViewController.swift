//
//  CloudViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/12.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit
import PhotosUI

class CloudViewController: UIViewController {
    
    // Identifier와 PHPickerResult로 만든 Dictionary
    private var selections = [String : PHPickerResult]()
    // 선택한 사진의 순서에 맞게 배열로 Identifier들을 저장
    private var selectedAssetIdentifiers = [String]()
    
    let button: UIButton = {
        let button = WYAddButton(.big)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = true
        tableView.contentInset = .zero
        tableView.register(CloudTableViewCell.self, forCellReuseIdentifier: CloudTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "오징어들의 오사카 여행"
        label.textColor = UIColor(named: "MainColorDark")
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.16 - 2023.11.20"
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    let downButton = UIBarButtonItem(
        image: UIImage(systemName: "square.and.arrow.down"),
        style: .plain,
//        target: self,
        target: nil,
        action: #selector(downButtonTapped)
    )
    
    let checkButton = UIBarButtonItem(
        image: UIImage(systemName: "checkmark.circle"),
        style: .plain,
//        target: self,
        target: nil,
        action: #selector(checkButtonTapped)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cloud"
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItems = [downButton, checkButton]
        
        setTableView()
        setViews()
        setConstriants()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.reloadData()
        
    }
    
    func setViews() {
        view.addSubview(mainLabel)
        view.addSubview(dateLabel)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func setConstriants() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            //            $0.centerX.equalToSuperview().of
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-130)
        }
    }
    
    @objc func buttonHandler(_ sender: UIButton) {
        presentPicker()
    }
    
    private func presentPicker() {
        // 이미지의 Identifier를 사용하기 위해서는 초기화를 shared로 해줘야 함
        var config = PHPickerConfiguration(photoLibrary: .shared())
        // 라이브러리에서 보여줄 Assets을 필터함 (기본값: 이미지, 비디오, 라이브포토)
        config.filter = PHPickerFilter.any(of: [.images])
        // 다중 선택 갯수 설정 (0 = 무제한)
        config.selectionLimit = 3
        // 선택 동작을 나타냄
        config.selection = .ordered
        
        config.preferredAssetRepresentationMode = .current
        // 이 동작이 있어야 Picker를 실행 시, 선택했던 이미지를 기억해 표시
        config.preselectedAssetIdentifiers = selectedAssetIdentifiers
        
        // 만든 Configuration를 사용해 PHPicker 컨트롤러 객체 생성
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true)
    }
    
    
    private func displayImage() {
        // 처음 스택뷰의 서브뷰들을 모두 제거함
//        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let dispatchGroup = DispatchGroup()
        // identifier와 이미지로 dictionary를 만듦(순서)
        var imagesDict = [String: UIImage]()
        
        for (identifier, result) in selections {
            
            dispatchGroup.enter()
            
            let itemProvider = result.itemProvider
            // 만약 itemProvider에서 UIImage로 로드가 가능하다면?
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                // 로드 핸들러를 통해 UIImage를 처리해 줍시다. (비동기적으로 동작)
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    
                    guard let image = image as? UIImage else { return }
                    
                    imagesDict[identifier] = image
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            
            guard let self = self else { return }
            
            for identifier in self.selectedAssetIdentifiers {
                guard let image = imagesDict[identifier] else { return }
                processImage(image)
            }
        }
    }
    
    func processImage(_ image:UIImage) {
        print("g")
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CloudTableViewCell {
                    cell.configure(with: selections, selectedAssetIdentifiers)
                }
    }
    
    
//    private func addImage(_ image: UIImage) {
//
//        let imageView = UIImageView()
//        imageView.image = image
//
//        imageView.snp.makeConstraints {
//            $0.width.height.equalTo(200)
//        }
//
////        self.stackView.addArrangedSubview(imageView)
//    }
    
    @objc func downButtonTapped() {
        
    }
    
    @objc func checkButtonTapped() {
        
    }
}

extension CloudViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CloudTableViewCell.identifier, for: indexPath) as! CloudTableViewCell
        cell.updateCollectionViewHeight()
//        cell.setImages(selections, selectedAssetIdentifiers)
//        cell.configure(with: selections, selectedAssetIdentifiers)

        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return CloudTableViewCell.cellHeight
    //    }
}

extension CloudViewController : PHPickerViewControllerDelegate {
    // picker가 종료되면 동작
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // picker가 선택이 완료되면 화면 내리기
        picker.dismiss(animated: true)
        
        // Picker의 작업이 끝난 후, 새로 만들어질 selections을 담을 변수를 생성
        var newSelections = [String: PHPickerResult]()
        
        for result in results {
            let identifier = result.assetIdentifier!
            newSelections[identifier] = selections[identifier] ?? result
        }
        
        // selections에 새로 만들어진 newSelection을 넣어주기
        selections = newSelections
        // Picker에서 선택한 이미지의 Identifier들을 저장 (assetIdentifier은 옵셔널 값이라서 compactMap 받음)
        // 위의 PHPickerConfiguration에서 사용하기 위해서
        selectedAssetIdentifiers = results.compactMap { $0.assetIdentifier }
        
        
        // 만약 비어있다면 스택뷰 초기화, selection이 하나라도 있다면 displayImage 실행
        if selections.isEmpty {
//            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        } else {
            displayImage()
        }
    }
}
