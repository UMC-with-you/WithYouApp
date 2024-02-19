

import Foundation
import RxSwift
import SnapKit
import UIKit

class CloudTestViewController : UIViewController {
    var bag = DisposeBag()
    var replyId = 0
    //Commnet 만들고 설정해주세요"
    var commentId = 1
    
    var label = UILabel()
    var button1 = WYButton("add")
    var button2 = WYButton("get")
    var button3 = WYButton("Delete")
 
    
    override func viewDidLoad() {
        [label,button1,button2,button3].forEach{
            view.addSubview($0)
        }
        button1.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        button2.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button1.snp.bottom).offset(15)
        }
        button3.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button2.snp.bottom).offset(15)
        }

        
        label.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        setFunc()
        label.textColor = .white
    }
    
    private func setFunc(){
        button1.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                MemberService.shared.changeName(name: "박복동"){
                    
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                MemberService.shared.changeImage(profilePicture: WithYouAsset.angry.image){
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                MemberService.shared.getInfo { Member in
                    print(Member)
                }
            }
            .disposed(by: bag )
    
    }
}
