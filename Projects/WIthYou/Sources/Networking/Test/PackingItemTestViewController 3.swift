

import Foundation
import RxSwift
import SnapKit
import UIKit

class PackingItemTestViewController : UIViewController {
    var bag = DisposeBag()
    var travelId = 4
    
    var packingItemID = [Int]()
    
    var label = UILabel()
    var button1 = WYButton("AddItemTest")
    var button2 = WYButton("GetItemTest")
    var button3 = WYButton("SetItemResponsablityTest")
    var button4 = WYButton("Toggle")
    var button5 = WYButton("Delete")
    
    override func viewDidLoad() {
        [label,button1,button2,button3,button4,button5].forEach{
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
        button4.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button3.snp.bottom).offset(15)
        }
        button5.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button4.snp.bottom).offset(15)
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
                PackingItemService.shared.addItem(travelId: self.travelId, itemName: "테스트 추가"){ response in
                    self.packingItemID.append(response.packingItemId)
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                PackingItemService.shared.getItemList(travelId: self.travelId){ response in
                     
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                PackingItemService.shared.setItemMember(packingItemId: self.packingItemID[0], memberId: 2){ response in
                }
            }
            .disposed(by: bag )
        
        button4.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                PackingItemService.shared.checkItem(packingItemId: self.packingItemID[0]) { _ in
                    
                }
            })
            .disposed(by: bag )
        
        button5.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                PackingItemService.shared.deleteItem(packingItemId: self.packingItemID[0]){ _ in
                    
                }
            })
            .disposed(by: bag )
    }
    
}
