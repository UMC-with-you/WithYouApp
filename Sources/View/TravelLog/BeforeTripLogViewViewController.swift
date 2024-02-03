//
//  BeforeTripLogViewViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/16/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import RxCocoa
import RxSwift
import UIKit
import Alamofire
class BeforeTripLogViewViewController: UIViewController {
    //D-day
    let day = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 32)
        label.textColor = .black
        return label
    }()
    
    //Log title
    //아래 줄 생성 예정
    let logTitle = {
       let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 20)
        label.textColor = .black
        return label
    }()
    //Notice
    let noticeView = NoticeView()
    //Packing Together
    let packingContainer = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = WithYouAsset.subColor.color.cgColor
        container.layer.borderWidth = 1.0
        container.layer.cornerRadius = 15
        container.clipsToBounds = true
        return container
    }()
    
    let packingHeader = {
        let section = TwoComponentLineView("Packing Together", imageView: UIImageView(image: UIImage(named: "PackingIcon")))
        section.changeConst {
            section.imageView.snp.updateConstraints{
                $0.width.height.equalTo(32)
            }
        }
        section.label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        return section
    }()
    
    let packingListView = {
        //CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 50)
        let list = UICollectionView(frame: .zero,collectionViewLayout: layout)
        list.register(PackingTableCell.self, forCellWithReuseIdentifier: PackingTableCell.cellId)
        return list
    }()
    
    //Add package
    let addPackageContainer = {
       let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.layer.cornerRadius = 10
        return uv
    }()
    let textField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.placeholder = "짐 추가하기"
        textField.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        textField.textColor = WithYouAsset.mainColorDark.color
        return textField
    }()
    let addPackageButton = WYAddButton(.small)
    
    var dummyData = PublishSubject<[PackingItem]>()

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        setUp()
        setConst()
        
        day.text = "D-20"
        logTitle.text = "오징어들의 오사카 여행"

        
        //Testing
        let packingItemList = [
            PackingItem(id: 0, logId: 1, itemName: "드라이기"),
            PackingItem(id: 1, logId: 1, itemName: "로션"),
            PackingItem(id: 2, logId: 1, itemName: "샴푸"),
            PackingItem(id: 3, logId: 1, itemName: "수건")
        ]
        
        let dummyTravler = [
            Traveler(id: 0, name: "박우주", profilePicture: ""),
            Traveler(id: 1, name: "우박주", profilePicture: ""),
            Traveler(id: 2, name: "주박우", profilePicture: ""),
            Traveler(id: 3, name: "우우우", profilePicture: "")
        ]
        
        AF.request("http://54.150.234.75:8080/api/v1/travels/1").response { response in
            print(response)
            
        }
        
        //CollectionView Style
        dummyData
            .bind(to: packingListView.rx.items(cellIdentifier: PackingTableCell.cellId, cellType: PackingTableCell.self)) { index, item, cell in
                cell.itemName.text = item.itemName
                cell.bindTravlers(travelers: dummyTravler)
            }
            .disposed(by: disposeBag)

        dummyData.onNext(packingItemList)
    }
    
    private func setUp(){
        [day,logTitle,noticeView,addPackageContainer,packingContainer].forEach{
            view.addSubview($0)
        }
        
        //Packing Together
        [packingHeader,packingListView].forEach{
            packingContainer.addSubview($0)
        }
        
        //AddPackage
        [textField,addPackageButton].forEach{
            addPackageContainer.addSubview($0)
        }
    }
    
    private func setConst(){
        
        day.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        logTitle.snp.makeConstraints{
            $0.leading.equalTo(day)
            $0.top.equalTo(day.snp.bottom).offset(20)
        }
        
        //NoticeView
        noticeView.snp.makeConstraints{
            $0.top.equalTo(logTitle.snp.bottom).offset(15)
            $0.height.equalTo(170)
            $0.width.equalTo(packingContainer.snp.width)
            $0.centerX.equalToSuperview()
        }
        
        //Packing Together List
        packingContainer.snp.makeConstraints{
            $0.width.equalTo(addPackageContainer.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(addPackageContainer.snp.top).offset(-20)
        }
        packingHeader.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }
        packingListView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(packingHeader.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
        
        //Adding Package
        addPackageContainer.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            //추후 위의 뷰와 거리 계산
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        textField.snp.makeConstraints{
            $0.width.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(46)
        }
        
        addPackageButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
}


extension BeforeTripLogViewViewController: UITextFieldDelegate{

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
}

