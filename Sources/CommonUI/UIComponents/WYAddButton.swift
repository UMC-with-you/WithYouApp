//
//  WYAddButton.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import  UIKit

public enum SizeOption : Int{
    case big = 42
    case small = 27
}

public class WYAddButton: UIButton {
    var size : SizeOption = .big
    
    let image = {
        let img = UIImage(systemName: "plus")
        let view = UIImageView(image: img)
        view.tintColor = .white
        return view
    }()

    public init(_ size : SizeOption = .big){
        super.init(frame:CGRect.zero)
        self.size = size
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton(){
        
        self.layer.cornerRadius = CGFloat(size.rawValue/2)
        self.backgroundColor = UIColor(named:"MainColorDark")
        
        self.addSubview(image)

        self.snp.makeConstraints{
            $0.width.equalTo(size.rawValue)
            $0.height.equalTo(size.rawValue)
        }

        image.snp.makeConstraints{
            $0.width.equalTo(size == .big ? size.rawValue/2 : size.rawValue - 7)
            $0.height.equalTo(size == .big ? size.rawValue/2 : size.rawValue - 7)
            $0.center.equalToSuperview()
        }
    }
    
}
