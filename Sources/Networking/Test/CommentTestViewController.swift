

import Foundation
import RxSwift
import SnapKit
import UIKit

class CommentTestViewController : UIViewController {
    var bag = DisposeBag()
    var postId = 3
    var commnetId = 0
    
    var label = UILabel()
    var button1 = WYButton("PostCommentTest")
    var button2 = WYButton("PatchCommentTest")
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
                CommentService.shared.addComment(postId: self.postId, content: "테스트 대댓ㅅㅅㅅ글"){ response in
                    self.commnetId = response.commentId
                }
            }
            .disposed(by: bag )
        
        button2.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                CommentService.shared.editComment(commentId: self.commnetId, content: "대댓글수ㅜㅜㅜㅅ정"){ _ in
                    
                }
            }
            .disposed(by: bag )
        
        button3.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                CommentService.shared.deleteComment(commentId: self.commnetId){ _ in
                }
            }
            .disposed(by: bag )
    }
}
