//
//  TwoComponentLineView.swift
//  WithYou
//
//  Created by 김도경 on 1/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit

// 2개의 components가 들어가는 라인 뷰
// 버튼 : 설명~ 식의 스타일
class TwoComponentLineView: UIView{
    
    let label = {
          let label = UILabel()
        label.textColor = WithYouAsset.mainColorDark.color
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
           return label
       }()
       
       var imageView : UIView!
       
       override init(frame: CGRect) {
           self.imageView = UIView()
           super.init(frame: frame)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       init(_ label : String, imageView : UIView){
           super.init(frame: .zero)
           self.label.text = label
           self.imageView = imageView
           setUp()
       }
       
    func setUp(){
        self.addSubview(imageView)
        self.addSubview(label)
        
        imageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            if imageView is WYAddButton {
            } else {
                $0.height.width.equalTo(28)
            }
        }
        
        label.snp.makeConstraints{
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
        }
    }
    
    
    public func changeConst(completion : () -> Void){
        completion()
    }
}
