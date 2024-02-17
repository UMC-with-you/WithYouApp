

import Foundation
import RxSwift
import SnapKit
import UIKit

class TravelLogTest : UIViewController {
    var bag = DisposeBag()
    var travelId = 0
    
    var label = UILabel()
    var button1 = WYButton("AddLogTest")
    var button2 = WYButton("GetLogTest")
    var button3 = WYButton("EditRewindTest")
    var button4 = WYButton("Delete")
    var button5 = WYButton("Invitation")
    
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
                LogService.shared.addLog(log: Log(id: 0, title: "테스트", startDate: "2024-03-01", endDate: "2024-03-05", status: "여행 전", imageUrl: "")){ response in
                    self.travelId = response.travelId
                    
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                LogService.shared.getAllLogs(){ logs in
                    print(logs)
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                LogService.shared.editLog(logId: self.travelId, editRequest: EditLogRequest(title: "수정 테스트", startDate: "2024-03-01", endDate: "2024-03-03", url: "",localDate: dateController.dateToSendServer())){_ in 
                    
                }
            }
            .disposed(by: bag )
        
        button4.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                LogService.shared.deleteLog(logId: self.travelId){ _ in
                    
                }
            })
            .disposed(by: bag )
        
        button5.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                LogService.shared.getInviteCode(logId: self.travelId){ _ in
                    
                }
            })
            .disposed(by: bag )
    }
    
}
