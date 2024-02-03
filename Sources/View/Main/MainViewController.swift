//
//  ViewController.swift
//
//  Created by 김도경 on 1/8/24.
//

import SnapKit
import RxCocoa
import RxGesture
import RxSwift
import UIKit

import Alamofire

class MainViewController: UIViewController {
    let header = TopHeader()
    
    let button = WYAddButton(.big)
    
    //Log가 있을 때 보여지는 뷰
    let logViewContainer = UIView()
    let eclipse = {
        let view = UIView()
        view.frame = CGRect(x: 0,y: 0,width: 5,height: 5)
        view.backgroundColor = WithYouAsset.mainColorDark.color
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    let upcoming = {
        let label = UILabel()
        label.text = "UPCOMING"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
        label.textColor = .black
        return label
    }()
    let ing = {
        let label = UILabel()
        label.text = "ING"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
        label.textColor = .black
        return label
    }()
    
    var logViews : [LogView] = []
    
    //Log가 없을 때 보여지는 뷰
    let emptyLogView = UIView()
    let info = {
       let label = UILabel()
        label.text = "Travel Log를 만들어 \n with 'You'를 시작해보세요!"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.numberOfLines = 2
        label.textColor = UIColor(named: "MainColorDark")
        label.setLineSpacing(spacing: 10)
        label.textAlignment = .center
        return label
    }()

    let mascout = {
        let img = UIImageView(image: UIImage(named: "Mascout"))
        return img
    }()
    
    var isLogEmpty : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    var isUpcoming : BehaviorSubject<Bool> = BehaviorSubject(value: true)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 1. if logs.count == 0 ? emptyLogView : lgoView
        /*
        for i in 0...2{
            let log = Log(id: i, text: "오징어들의 파리 여행",startDate: "2024.02.13", endDate: "2024.03.01", media: URL(fileURLWithPath: "www.naver.com"))
            let logView = LogView(frame: CGRect(), log: log)
            logViews.append(logView)
        }
         */
        let parameter = [
            "currentLocalDate" : dateController.getDate(Date())
        ]
        let header : HTTPHeaders = [
            "Authorization": "1",
        ]
        
        APIManager.shared.getData(urlEndPoint: "/travels",parameter: parameter,header: header, dataType: APIContainer<[Log]>.self){ result  in
            print(result)
        }
        
        
      
        
        
        // 2. if logs.count != 0 ? 여행중인지 아닌지 판단 후 표시 / default는 여행 중 아님
        
        setViews()
        setConst()
        setFuncs()
        setSubscribes()
    }
    
    func setSubscribes(){
        
        
        
        //터치에 따른 ING or UPCOMING 색 변경
        isUpcoming.subscribe(onNext: {
            if $0 {
                self.ing.textColor = WithYouAsset.subColor.color
                self.upcoming.textColor = WithYouAsset.mainColorDark.color
                self.eclipse.snp.updateConstraints{ ecl in
                    ecl.centerX.equalTo(self.upcoming.snp.centerX)
                }
            } else {
                self.ing.textColor = WithYouAsset.mainColorDark.color
                self.upcoming.textColor = WithYouAsset.subColor.color
                self.eclipse.snp.updateConstraints{ ecl in
                    ecl.centerX.equalTo(self.upcoming.snp.centerX).offset(-115)
                }
            }
        })
        .disposed(by: disposeBag)
        
        // 로그 존재 여부에 따른 뷰 설정
        isLogEmpty.subscribe(onNext: {
            if $0 {
                self.emptyLogView.isHidden = false
                self.logViewContainer.isHidden = true
            } else {
                self.emptyLogView.isHidden = true
                self.logViewContainer.isHidden = false
            }
        })
        .disposed(by: disposeBag)
        
        
        // 로그 존재 여부에 따른 버튼 위치 조절
        isLogEmpty.subscribe(onNext: { logStatus in
            self.button.snp.updateConstraints{
                $0.bottom.equalToSuperview().offset(logStatus ? -300 : -130)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func loadLogs(){
        //log불러오는 함수
    }
    
    private func setFuncs(){
        button.rx.tap
            .bind{
            self.popUpLogOption()
        }
        .disposed(by: disposeBag)
        
        ing.rx.tapGesture()
            .when(.recognized)
            .bind{ _ in
                self.ingClicked()
            }
            .disposed(by: disposeBag)

        upcoming.rx.tapGesture()
            .when(.recognized)
            .bind{ _ in
                self.upcomingClicked()
            }
            .disposed(by: disposeBag)
 
        logViews.forEach{
            $0.rx.tapGesture()
                .when(.recognized)
                .bind{ _ in
                    self.navigateToLog()
                }
                .disposed(by: disposeBag)
        }
    }
    
    private func setViews(){
        [header,emptyLogView,logViewContainer,button].forEach{
            view.addSubview($0)
        }
        
        //로그 없을 때 보여지는 View
        [mascout,info].forEach {
            emptyLogView.addSubview($0)
        }
        
        //로그가 존재할때 보여지는 View
        [ing,upcoming,eclipse].forEach {
            logViewContainer.addSubview($0)
        }
        
        logViews.forEach{
            logViewContainer.addSubview($0)
        }
    }
    
    private func setConst(){
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        emptyLogView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalToSuperview()
        }
        
        mascout.snp.makeConstraints{
            $0.height.equalTo(58)
            $0.width.equalTo(115)
            $0.bottom.equalTo(info.snp.top).offset(-35)
            $0.centerX.equalToSuperview()
        }
        
        info.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
        
        logViewContainer.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.bottom.equalToSuperview()
        }

        
        ing.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview().offset(-60)
        }
        
        upcoming.snp.makeConstraints{
            $0.top.equalTo(ing.snp.top)
            $0.leading.equalTo(ing.snp.trailing).offset(50)
        }
        
        eclipse.snp.makeConstraints{
            $0.top.equalTo(ing.snp.bottom).offset(10)
            $0.width.height.equalTo(5)
            try! $0.centerX.equalTo(isUpcoming.value() ? upcoming.snp.centerX : ing.snp.centerX)
        }
        
        logViews.reversed().enumerated().forEach{ index, item in
            item.snp.makeConstraints{
                $0.centerX.equalToSuperview().offset(index * 20)
                $0.centerY.equalToSuperview().offset(-50)
                $0.width.equalToSuperview().multipliedBy(0.75)
                $0.height.equalToSuperview().multipliedBy(0.53)
            }
        }

        button.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            try! $0.bottom.equalToSuperview().offset(isLogEmpty.value() ? -300 : -130)
        }
    }
}

extension MainViewController{
    // log 만드는 옵션
    func popUpLogOption(){
        let modalVC = NewLogSheetView()
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in

            return UIScreen.main.bounds.height / 3.5
        }
        
        if let sheet = modalVC.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
      
        _ =  modalVC.commander.subscribe({ event in
            let newLogVC = CreateTravelLogViewController()
            self.navigationController?.pushViewController(newLogVC, animated: true)
        })

        present(modalVC, animated: true)
    }
    
    // 로그 터치시 해당 로그 상세 페이지로 이동
   func navigateToLog(){
        // 클릭한 log의 정보를 가져와서 열어야함
        // 백엔드측에서는 id로 가져올 수 있음
        // rx사용하면 가능함!
        let logVC = BeforeTripLogViewViewController() // 1.  여기에 ID를 넣어서 controller가 가져오게 하는 방법 ?
        self.navigationController?.pushViewController(logVC, animated: true)
    }
    
    // Upcoming Ing Label 클릭시
    func upcomingClicked(){
        self.isUpcoming.onNext(true)
    }
    
    func ingClicked(){
        self.isUpcoming.onNext(false)
    }
}
