//
//  PostCommentViewMdoel.swift
//  WithYou
//
//  Created by bryan on 9/19/24.
//

import Foundation
import RxSwift

public final class PostCommentViewModel {
        
    public let post : Post
    public var commentSubject = PublishSubject<[Comment]>()
    
    public var isReply = PublishSubject<Bool>()
    
    init(post : Post){
        self.post = post
    }
    
    public func loadComments(){
        var comments = [Comment]()
        for comment in post.comments {
            if let c = comment {
                comments.append(c)
            }
        }
        self.commentSubject.onNext(comments)
    }
    
    public func addCommnet(_ text : String){
        //추가
    }
}
