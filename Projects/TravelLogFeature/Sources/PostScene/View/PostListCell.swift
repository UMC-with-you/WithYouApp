//
//  PostListCell.swift
//  TravelLogFeature
//
//  Created by bryan on 7/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public class PostListCell : UICollectionViewCell {
    static let cellId = "PostThumbCollectionViewCell"
    
    let thumb = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(thumb)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //킹피셔 사용안할때
    public func bind(){
        self.thumb.image = UIImage(named: "LogModel0")
        
        thumb.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
    }
    // 킹피셔 추후 사용
//    func bind(imageUrl:String){
//        self.thumb.kf.setImage(with: URL(string:imageUrl))
//        thumb.snp.makeConstraints{
//            $0.width.height.equalToSuperview()
//        }
//    }
}
