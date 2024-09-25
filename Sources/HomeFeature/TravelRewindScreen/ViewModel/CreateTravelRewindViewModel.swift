//
//  CreateTravelRewindViewModel.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import RxSwift

final public class CreateTravelRewindViewModel {
    
    public let log : Log
    private let rewindUseCase : RewindUseCase
    private let logUseCase : LogUseCase
    
    let moodImageTags = [
        "heart","lucky","surprised","angry","touched","sunny","sad","soso"
    ]
    
    private var mvpTraveler : Traveler?
    
    public var rewindQnaSubject = PublishSubject<[RewindQna]>()
    public var travelersSubject = PublishSubject<[Traveler]>()
    
    private var disposeBag = DisposeBag()
    
    var moodTag = ""
    
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

}
