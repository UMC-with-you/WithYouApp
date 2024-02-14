//
//  CloudViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/12.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class CloudViewController: UIViewController {
    
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
    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        //        layout.minimumLineSpacing = 10
//        //        layout.minimumInteritemSpacing = 10
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return collectionView
//    }()
    
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
        target: self,
        action: #selector(downButtonTapped)
    )
    
    let checkButton = UIBarButtonItem(
        image: UIImage(systemName: "checkmark.circle"),
        style: .plain,
        target: self,
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
        tableView.backgroundColor = .brown
        tableView.reloadData()
       
    }
    
    func setViews() {
        view.addSubview(mainLabel)
        view.addSubview(dateLabel)
        view.addSubview(tableView)
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
    }
    
    @objc func downButtonTapped() {
        
    }
    
    @objc func checkButtonTapped() {
        
    }
}

extension CloudViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CloudTableViewCell.identifier, for: indexPath) as! CloudTableViewCell
        cell.updateCollectionViewHeight()
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CloudTableViewCell.cellHeight
//    }
}

//extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    // cell 갯수
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        default:
//            return 24
//            //            return userPosts?.count ?? 0
//        }
//    }
//
//    // cell 생성
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let section = indexPath.section
//        switch section {
//        case 0:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
//                fatalError("셀 타입 캐스팅 실패")
//            }
//            cell.navigationController = self.navigationController
//            return cell
//        default:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
//                fatalError("셀 타입 캐스팅 실패")
//            }
//            return cell
//        }
//    }
//}
//
//
//extension CloudViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let section = indexPath.section
//        switch section {
//        case 0:
//            return CGSize(width: collectionView.frame.width, height: CGFloat(160))
//        default:
//            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
//            return CGSize(width: side, height: side)
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return 0
//        default:
//            return 1
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return 0
//        default:
//            return 1
//        }
//    }
//}
