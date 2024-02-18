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

class RewindTestViewController : UIViewController {
    var bag = DisposeBag()
    var rewindId = 2
    var travelId = 12
    
    var label = UILabel()
    var button1 = WYButton("RewindPostTest")
    var button2 = WYButton("GetRewindTest")
    var button3 = WYButton("EditRewindTest")
    var button4 = WYButton("Delete")
    var button5 = WYButton("GetOneRewindTest")
    var button6 = WYButton("GetQnaList")
    
    override func viewDidLoad() {
        [label,button1,button2,button3,button4,button5,button6].forEach{
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
        button6.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button5.snp.bottom).offset(15)
        }
    
        setFunc()
        label.textColor = .white
    }
    
    private func setFunc(){
        button1.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                let request = RewindPostRequest(day: 1,
                                                mvpCandidateId: 2,
                                                mood: "SAD",
                                                qnaList: [
                                                    RewindQnaPostRequest(qnaId: 94, answer: "good"),
                                                    RewindQnaPostRequest(qnaId: 105, answer: "hi")
                                                ],
                                                comment: "좋았습니다")
                RewindService.shared.postRewind(rewindPostRequest: request, travelId: self.travelId){ response in
                   // self.label.text = response.createdAt
                    self.rewindId = response.rewindId
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                RewindService.shared.getAllRewind(travelId: self.travelId, day: 1){ response in
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                //edit qnaID로 해야함 질문 id 아니고
                RewindService.shared.editRewind(rewindEditRequest: RewindEditRequest(mvpCandidateId: 2, mood: "SAD", qnaList: [
                    RewindQnaPostRequest(qnaId: 3, answer: "bad"),
                    RewindQnaPostRequest(qnaId: 4, answer: "qwertty")
                ], comment: "되자"), travelId: self.travelId, rewindId: self.rewindId){ response in
                    print(response)
                }
            }
            .disposed(by: bag )
        
        button4.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                RewindService.shared.deleteRewind(travelId: self.travelId, rewindId: self.rewindId){ response in
                }
            })
            .disposed(by: bag )
        
        button5.rx.tapGesture().when(.recognized)
            .subscribe{ _ in
                RewindService.shared.getOneRewind(travelId: self.travelId, rewindId: self.rewindId) { response in
                }
            }
            .disposed(by: bag)
        
        button6.rx.tapGesture().when(.recognized)
            .subscribe{ _ in
                RewindService.shared.getQnaList{ response in
                    
                }
            }
            .disposed(by: bag)
        
        
    }
}
