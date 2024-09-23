//
//  AddPostPhotoCell.swift
//  WithYou
//
//  Created by bryan on 9/20/24.
//
import Kingfisher
import SnapKit
import UIKit

class AddPostPhotoCell: UICollectionViewCell {
    static let cellId = "AddPostPhotoCell"
    
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
    public func makeConst(){
        thumb.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
    }
    
    func bind(imageUrl:String){
        self.thumb.kf.setImage(with: URL(string:imageUrl))
        thumb.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
    }
}
