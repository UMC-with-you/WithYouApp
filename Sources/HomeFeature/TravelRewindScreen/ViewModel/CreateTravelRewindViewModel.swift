//
//  CreateTravelRewindViewModel.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import RxSwift
import RxRelay

final public class CreateTravelRewindViewModel {
    
    public let log : Log
    private let rewindUseCase : RewindUseCase
    private let logUseCase : LogUseCase
    
    private var disposeBag = DisposeBag()
    
    let moodImageTags = [
        "heart","lucky","surprised","angry","touched","sunny","sad","soso"
    ]
    
    public var rewindQnaSubject = PublishSubject<[RewindQna]>()
    public var travelersSubject = PublishSubject<[Traveler]>()
    public var buttonColorRelay = BehaviorRelay<Bool>(value: false)
    
    private var mvpTraveler : Traveler?
    public var textField2String : String = ""
    public var textField3String : String = ""
    public var textField4String : String = ""
    public var textField5String : String = ""

    var moodTag = ""
    var rewindQna : [RewindQna] = []
    
    init(log: Log, rewindUseCase: RewindUseCase, logUseCase: LogUseCase) {
        self.log = log
        self.rewindUseCase = rewindUseCase
        self.logUseCase = logUseCase

    }
    
    public func loadData(){
        rewindUseCase.getQnaList()
            .subscribe(onSuccess: { rewinds in
                var randomRewinds = [RewindQna]()
                for _ in 0..<4 {
                    randomRewinds.append(rewinds.randomElement()!)
                }
                self.rewindQnaSubject.onNext(randomRewinds)
                self.rewindQna = randomRewinds
            })
            .disposed(by: disposeBag)
        
        logUseCase.getAllLogMembers(travelId: log.id)
            .subscribe { travelers in
                self.travelersSubject.onNext(travelers)
            }
            .disposed(by: disposeBag)
    }
    
    public func selectMVP(_ traveler: Traveler){
        self.mvpTraveler = traveler
    }
    
    public func checkInputs(){
        if moodTag != "" &&
            textField2String != "" &&
            textField3String != "" &&
            textField4String != "" &&
            textField5String != "" &&
            mvpTraveler != nil {
            buttonColorRelay.accept(true)
        } else {
            buttonColorRelay.accept(false)
        }
    }
    
    public func createRewind(){
        var list = [RewindQna]()
        let textList = [textField2String,textField3String,textField4String,textField5String]
        for i in 0..<rewindQna.count {
            let qna = rewindQna[i]
            list.append(RewindQna(qnaId: qna.qnaId, questionId: qna.questionId, content: qna.content, answer: textList[i] ))
        }
        rewindUseCase.createRewind(day: dateController.daysAsInt(from: log.startDate), mvpCandidateId: mvpTraveler?.id ?? 0, mood: moodTag, qnaList: list, comment: "", travelId: log.id)
            .subscribe { a in
                print(a)
            }
            .disposed(by: disposeBag)
    }
}
