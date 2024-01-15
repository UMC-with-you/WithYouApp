//
//  ViewController.swift
//
//  Created by 김도경 on 1/8/24.
//

import SnapKit
import RxSwift
import UIKit

class MainViewController: UIViewController {
    let header = TopHeader()
    
    let button = WYAddButton(.big)
    
    let info = {
       let label = UILabel()
        label.text = "Travel Log를 만들어 \n with 'You'를 시작해보세요!"
        label.font = .systemFont(ofSize: 16)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /*
         1. Log 불러와서 if nil = 안내 문구 페이지 else Log 화면 불러오기
         2. Button click시 Navigation 필요
         3. Log 클릭시도 Navigation 필요
         */
        
        setViews()
        setConst()
        setFuncs()
    }
    
    
    private func setFuncs(){
        self.button.addTarget(self, action: #selector(createNewTravelog), for: .touchUpInside)
    }
    
    
    private func setViews(){
        view.addSubview(header)
        view.addSubview(button)
        view.addSubview(info)
        view.addSubview(mascout)
    }
    
    private func setConst(){
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        info.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        mascout.snp.makeConstraints{
            $0.height.equalTo(58)
            $0.width.equalTo(115)
            $0.bottom.equalTo(info.snp.top).offset(-35)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints{
            $0.top.equalTo(info.snp.bottom).offset(65)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MainViewController{
    // Functions
    @objc func createNewTravelog(){
        let modalVC = BottomSheetView()
        
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return UIScreen.main.bounds.height / 3
        }
        
        if let sheet = modalVC.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = true
        }
        self.present(modalVC, animated: true)
    }
}
