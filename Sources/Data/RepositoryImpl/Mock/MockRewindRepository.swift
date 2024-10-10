//
//  MockRewindRepository.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import RxSwift

public final class MockRewindRepository : RewindRepository{
    
    var qnaList = [
        RewindQna(qnaId: 1, questionId: 101, content: "일본을 방문하기 좋은 시기는 언제인가요?", answer: "봄(3월~5월)이나 가을(9월~11월)이 날씨가 좋고 관광하기 좋은 시기입니다."),
        RewindQna(qnaId: 2, questionId: 102, content: "이탈리아 방문 시 비자가 필요한가요?", answer: "국적에 따라 다릅니다. 많은 국가들이 이탈리아와 단기 체류에 대해 비자 면제 협정을 맺고 있습니다."),
        RewindQna(qnaId: 3, questionId: 103, content: "파리에서 꼭 봐야 할 명소는 무엇인가요?", answer: "파리의 명소로는 에펠탑, 루브르 박물관, 노트르담 대성당, 센강 등이 있습니다."),
        RewindQna(qnaId: 4, questionId: 104, content: "한국에서 유럽으로 가는 가장 저렴한 방법은 무엇인가요?", answer: "저비용 항공사를 이용하거나 조기 예약, 비수기 여행이 가장 저렴한 방법입니다."),
        RewindQna(qnaId: 5, questionId: 105, content: "하와이에서 추천하는 액티비티는 무엇인가요?", answer: "하와이에서는 스노클링, 서핑, 하이킹, 헬리콥터 투어 등이 인기 있습니다."),
        RewindQna(qnaId: 6, questionId: 106, content: "영국 여행 시 주의할 점은 무엇인가요?", answer: "영국은 비가 자주 오니 우산을 준비하고, 대중교통이 복잡할 수 있어 미리 계획하는 것이 좋습니다."),
        RewindQna(qnaId: 7, questionId: 107, content: "여행 보험이 꼭 필요한가요?", answer: "예기치 못한 사고나 의료비를 대비해 여행 보험을 드는 것이 좋습니다."),
        RewindQna(qnaId: 8, questionId: 108, content: "뉴질랜드에서 꼭 가봐야 할 곳은 어디인가요?", answer: "뉴질랜드의 추천 명소로는 밀포드 사운드, 와이토모 동굴, 퀸스타운 등이 있습니다."),
        RewindQna(qnaId: 9, questionId: 109, content: "미국 여행 중 렌터카를 빌리려면 무엇이 필요한가요?", answer: "국제운전면허증과 여권, 신용카드가 필요하며, 일부 주에서는 한국 면허증만으로도 렌터카를 빌릴 수 있습니다."),
        RewindQna(qnaId: 10, questionId: 110, content: "배낭 여행에 가장 적합한 국가는 어디인가요?", answer: "태국, 베트남, 페루 등은 배낭 여행객들에게 인기 있는 국가들입니다.")
    ]
    
    var rewind = [Rewind]()
    var count = 0
    public func getAllRewind(travelId: Int, day: Int) -> Single<[Rewind]> {
        .just(rewind)
    }
    
    public func createRewind(day: Int, mvpCandidateId: Int, mood: String, qnaList: [RewindQna], comment: String, travelId: Int) -> Single<Int> {
        let newRewind = Rewind(rewindId: count, day: day, writerId: 0, mvpCandidateId: mvpCandidateId, mood: mood, comment: comment, rewindQnaList: qnaList, createdAt: dateController.currentDateToSendServer(), updatedAt: dateController.currentDateToSendServer())
        count += 1
        return .just(1)
    }
    
    public func getOneRewind(travelId: Int, rewindId: Int) -> Single<Rewind> {
        for r in rewind {
            if r.rewindId == rewindId {
                return .just(r)
            }
        }
        return .error("NOT FOUND" as! Error)
    }
    
    public func deleteRewind(travelId: Int, rewindId: Int) -> Single<String> {
        rewind = rewind.filter{ $0.rewindId == rewindId }
        return .just("Success")
    }
    
    public func editRewind(mvpCandidateId: Int, mood: String, qnaList: [RewindQna], comment: String, travelId: Int, rewindId: Int) -> Single<String> {
        for i in 0..<rewind.count {
            if rewind[i].rewindId == rewindId {
                rewind[i].mvpCandidateId = mvpCandidateId
                rewind[i].mood = mood
                rewind[i].rewindQnaList = qnaList
                rewind[i].comment = comment
                return .just("Success")
            }
        }
        return .just("failure")
    }
    
    public func getQnaList() -> Single<[RewindQna]> {
        return .just(qnaList)
    }
}
