//
//  RewindTestViewController.swift
//  WithYou
//
//  Created by 김도경 on 2/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift
import SnapKit
import UIKit

class NoticeTestViewController : UIViewController {
    var bag = DisposeBag()
    var noticeId = 1
    var logId = 4
    var label = UILabel()
    var button1 = WYButton("NoticePostTest")
    var button2 = WYButton("GetNoticeTest")
    var button3 = WYButton("EditNoticeTest")

    var button4 = WYButton("Delete")
    var button5 = WYButton("CheckNoticeTest")
    
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
            $0.top.equalTo(button1.snp.bottom).offset(20)
        }
        
        button3.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button2.snp.bottom).offset(20)
        }
        
        button4.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button3.snp.bottom).offset(20)
        }
        
        button5.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button4.snp.bottom).offset(20)
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
                NoticeService.shared.createNotice(info: ["state" : 0, "content": "테스트 아아"] , memberId: 2, logId: self.logId){ response in
                    self.noticeId = response.noticeId
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                NoticeService.shared.getOneNotice(noticeId: self.noticeId){ response in
                    print(response.noticeId)
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                NoticeService.shared.editNotice(notice: EditNoiceRequest(noticeId: self.noticeId, state: 1, content: "수정테스트")){ response in
                    
                }
            }
            .disposed(by: bag )
        
        button4.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                NoticeService.shared.deleteNotice(noticeId: self.noticeId){ response in
                    
                }
            })
            .disposed(by: bag )
        
        button5.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                NoticeService.shared.getAllNoticByLog(travelId: self.logId){ _ in
                    
                }
            })
            .disposed(by: bag )
    }
    
}
