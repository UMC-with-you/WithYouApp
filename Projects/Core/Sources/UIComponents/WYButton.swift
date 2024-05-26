import UIKit


public class WYButton : UIButton{
    
    public init(_ text : String){
        super.init(frame: CGRect.zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        self.backgroundColor = WithYouAsset.subColor.color
        self.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

