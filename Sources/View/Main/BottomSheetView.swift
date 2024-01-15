//
//  BottomSheetView.swift
//  WithYou
//
//  Created by 김도경 on 1/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class BottomSheetView: UIViewController {

    private let firstLine = {
        let line = TwoComponentLineView("새로운 Log 만들기", imageView: WYAddButton())
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConst()
    }
    
    private func setUp(){
        view.addSubview(firstLine)
    }
    
    private func setConst(){
        firstLine.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
        }
    }
}
