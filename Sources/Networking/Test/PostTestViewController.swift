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

///포스트 수정 에러
///- Swagger 에서 Response도 ReplyId가 온다고 되어있는데 Edit하는데 ReplyID가 오는게 조금 이상함
///포스트 삭제 에러
///- 스크랩 되어 있는 포스트 에러

class PostTestViewController : UIViewController {
    var bag = DisposeBag()
    var postId = 9
    var travelId = 2
    
    var label = UILabel()
    var button1 = WYButton("AddPostTest")
    var button2 = WYButton("GetAllPostTest")
    var button3 = WYButton("GetOnePostTest")
    var button4 = WYButton("ScrapPost")
    var button5 = WYButton("DeletePost")
    var button6 = WYButton("EditPost")
    var button7 = WYButton("GetAllScrapedPost")
    
    override func viewDidLoad() {
        [label,button1,button2,button3,button4,button5,button6,button7].forEach{
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
        button7.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button6.snp.bottom).offset(15)
        }
    
        setFunc()
        label.textColor = .white
    }
    
    private func setFunc(){
        button1.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                let newPost = NewPostStruct(text: "포스트 테스트", mediaList: [WithYouAsset.homeIcon.image,WithYouAsset.angry.image])
                PostService.shared.addPost(travelId: self.travelId, newPost: newPost){ response in
                    self.postId = response.postId
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                PostService.shared.getAllPost(travelId: self.travelId){ _ in
                    
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                PostService.shared.getOnePost(postId: self.postId, travelId: self.travelId){ _ in}
            }
            .disposed(by: bag )
        
        button4.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                PostService.shared.scrapPost(postId: self.postId) { response in
                    
                }
            })
            .disposed(by: bag )
        
        button5.rx.tapGesture().when(.recognized)
            .subscribe{ _ in
                PostService.shared.deletePost(postId: self.postId){ _ in
                    
                }
            }
            .disposed(by: bag)
        
        button6.rx.tapGesture().when(.recognized)
            .subscribe{ _ in
                var positions = [
                    "15" : 0,
                    "16" : -1
                ]
                PostService.shared.editPost(postId: self.postId, editContent: EditPostRequest(text: "수정함",newPositions: positions)){_ in
                    
                }
            }
            .disposed(by: bag)
        
        button7.rx.tapGesture().when(.recognized)
            .subscribe{ _ in
                PostService.shared.getScrapedPost(){_ in
                }
            }
            .disposed(by: bag)
        
        
    }
}
