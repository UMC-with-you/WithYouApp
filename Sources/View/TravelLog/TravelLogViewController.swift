//
//  TravelLogViewController.swift
//  WithYou
//
//  Created by 김도경 on 1/23/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//
import SnapKit
import RxSwift
import UIKit

class TravelLogViewController: UIViewController {
    
    let header = TopHeader()
    
    let searchBar = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = WithYouAsset.subColor.color.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let searchIcon = UIImageView(image: WithYouAsset.searchIcon.image)
    let searchField = {
        let field = UITextField()
        field.placeholder = "검색어를 입력해주세요"
        field.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        field.textColor = WithYouAsset.subColor.color
        field.borderStyle = .none
        return field
    }()
    let sortIcon = UIImageView(image: WithYouAsset.sortIcon.image)
    
    var gridView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.6, height: 225)
        
        let grid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        grid.register(LogGridViewCell.self, forCellWithReuseIdentifier: "LogGridCell")
    
        return grid
    }()
    
    var logList = [Log]()
    
    var logObservable = PublishSubject<[Log]>()
    
    let button = WYAddButton()

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //Log들 불러와서 LogList에 저장
        //logList = APIManager.shared.getData(<#T##url: URL##URL#>, parameter: <#T##Parameters#>, dataType: <#T##Decodable#>, <#T##completion: (Decodable) -> Void##(Decodable) -> Void#>)
        //logList = [Log(id: 0, title: "오징어들의 파리 여행",startDate: "2024.02.13", endDate: "2024.03.01", imageUrl: "www.naver.com"),
       // Log(id: 1, title: "여름보다 뜨거운 겨울 여행",startDate: "2024.03.13", endDate: "2024.03.23", imageUrl: "www.naver.com"),
       // Log(id: 2, title: "식폭행 전과자들",startDate: "2024.06.03", endDate: "2024.06.6", imageUrl: "www.naver.com")]
        // Observable로 뿌려주기
        
        gridView.backgroundColor = .systemBackground
        
        setUp()
        setConst()
        logObservable.onNext(logList)
    }
    
    func setUp(){
        [header,searchBar,sortIcon,gridView,button].forEach {
            view.addSubview($0)
        }
        [searchIcon,searchField].forEach{
            searchBar.addSubview($0)
        }
        
        
        logObservable
            .bind(to: gridView.rx.items(cellIdentifier: "LogGridCell", cellType: LogGridViewCell.self)) { index, item, cell in
                cell.bind(log: item)
            }
            .disposed(by: disposeBag)
    }
    
    func setConst(){
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        sortIcon.snp.makeConstraints{
            $0.width.height.equalTo(28)
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
        }
        //SearchBar
        searchBar.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(sortIcon.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        searchIcon.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        searchField.snp.makeConstraints{
            $0.leading.equalTo(searchIcon.snp.trailing).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerY.equalToSuperview()
        }
        
        gridView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        button.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.trailing.equalToSuperview().offset(-15)
        }
      
    }
    
    
}
