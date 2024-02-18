//
//  ByGoneTripLogViewVIewController.swift
//  WithYou
//
//  Created by 김도경 on 2/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxGesture
import RxSwift
import RxCocoa
import UIKit
import SnapKit

class ByGoneTripLogViewController: UIViewController {
    
    var log : Log?
    var travelMembers = BehaviorSubject<[Traveler]>(value: [])
    
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.bold.font(size: 32)
        label.text = "Travelog"
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .left
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        label.text = "오징어들의 오사카 여행"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 0.96, alpha: 1)
        return view
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = .gray
        return label
    }()
    
    let memberTitleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.text = "함께한 친구"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var memberCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20// cell사이의 간격 설정
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: 70, height: 88)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()
    
    let subLabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = .black
        label.text = "우리의 기록"
        return label
    }()
    
    let postBookView : UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 196/255, green: 215/255, blue: 250/255, alpha: 1)
        let systemImage = UIImage(named: "Postbook")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "Post Book"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "여행을 함께한 우리만의 SNS"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let rewindBookView: UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 154/255, green: 148/255, blue: 188/255, alpha: 1)
        let systemImage = UIImage(named: "Rewind")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "Rewind Book"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "오늘의 Rewind 모아보기"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let cloudVIew: UIView = {
        let view = TodayView()
        view.layer.cornerRadius = 10
    
        view.backgroundColor = UIColor(red: 242/255, green: 177/255, blue: 219/255, alpha: 1)
        let systemImage = UIImage(named: "Cloud")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "Cloud"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "우리들의 사진공유"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let sideMenu = UIImageView(image: UIImage(named: "SideMenu"))
    
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //NavigatoinBar button 설정
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: sideMenu), UIBarButtonItem(customView: ProfileView(size: .small, traveler: Traveler(id: 0, name: DataManager.shared.getUserName())))]
        
        setUp()
        setConstraints()
        setFunc()
        
        //멤버 갱신
        LogService.shared.getAllMembers(logId: self.log!.id){ response in
            self.travelMembers.onNext(response)
        }
    }
    
    private func setUp(){
        [topTitleLabel,mainLabel,dateLabel,memberTitleLabel,memberCollectionView,subLabel,postBookView,rewindBookView,cloudVIew].forEach{
            view.addSubview($0)
        }
        
        memberCollectionView.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.id)
    }
    
    public func bindLog(log : Log){
        self.log = log
        self.topTitleLabel.text = log.title
        self.dateLabel.text = "\(log.startDate.replacingOccurrences(of: "-", with: ".")) - \(log.endDate.replacingOccurrences(of: "-", with: ".")) "
    }
    
    private func setFunc(){
        //멤버 표시
        travelMembers.bind(to: memberCollectionView.rx.items(cellIdentifier: MemberCell.id, cellType: MemberCell.self)){ index, item , cell in
            cell.bind(traveler: item)
        }
        .disposed(by: bag)
        
        sideMenu.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                self.openSideMenu()
            }
            .disposed(by: bag)
    }
    
    func openSideMenu(){
        let sideMenu = SideBarViewController()
        sideMenu.modalPresentationStyle = .overFullScreen
        //Log 전달
        sideMenu.bind(log: self.log!,members: try! self.travelMembers.value())
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        present(sideMenu,animated: false)
    }
    
    private func setConstraints() {
        topTitleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        mainLabel.snp.makeConstraints{
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(topTitleLabel)
        }
        addUnderline(to: mainLabel, thickness: 7, color: UIColor(named: "UnderlineColor") ?? .black)
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.leading.equalTo(topTitleLabel)
        }
        
        memberTitleLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(topTitleLabel)
        }
        
        memberCollectionView.snp.makeConstraints{
            $0.width.equalTo(topTitleLabel.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.13)
            $0.top.equalTo(memberTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints{
            $0.leading.equalTo(topTitleLabel)
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(40)
        }
        
        postBookView.snp.makeConstraints{
            $0.top.equalTo(subLabel.snp.bottom).offset(20)
            $0.leading.equalTo(topTitleLabel)
            $0.width.equalTo(topTitleLabel).dividedBy(2.1)
            $0.height.equalTo(120)
        }
        
        rewindBookView.snp.makeConstraints{
            $0.top.equalTo(postBookView)
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.equalTo(topTitleLabel).dividedBy(2.1)
            $0.height.equalTo(120)
        }
        
        cloudVIew.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(rewindBookView.snp.bottom).offset(15)
            $0.width.equalTo(topTitleLabel)
            $0.height.equalTo(120)
        }
        
    }
}
extension ByGoneTripLogViewController {
    func addUnderline(to label: UILabel, thickness: CGFloat, color: UIColor) {
        let underline = UILabel()
        underline.backgroundColor = color
        view.addSubview(underline)
        underline.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(label)
            make.height.equalTo(thickness)
        }
        view.bringSubviewToFront(label)
    }
}
