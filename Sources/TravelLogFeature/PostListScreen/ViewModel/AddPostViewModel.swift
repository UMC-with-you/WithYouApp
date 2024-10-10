//
//  AddPostViewModel.swift
//  WithYou
//
//  Created by bryan on 9/20/24.
//

import Foundation
import PhotosUI
import RxSwift
import RxRelay

public final class AddPostViewModel {
    
    private let useCase : PostUseCase
    
    private var disposeBag = DisposeBag()
    
    public let log : Log
    
    public var isPicEmpty : Bool = true
    public var isTextEmpty : Bool = true
    
    public var selectedImages = BehaviorSubject<[UIImage]>(value: [])
    
    public var buttonStatus = BehaviorRelay<Bool>(value: false)
    
    public var finished = BehaviorRelay<Bool>(value: false)
    
    init(useCase: PostUseCase, log : Log) {
        self.useCase = useCase
        self.log = log
    }
    
    public func setImages(_ images : [UIImage]){
        if !images.isEmpty {
            isPicEmpty = false
        } else {
            isPicEmpty = true
        }
        selectedImages.onNext(images)
    }
    
    public func checkStatus(){
        if !isPicEmpty && !isTextEmpty {
            buttonStatus.accept(true)
        }
    }
    
    public func addPost(_ text : String){
        do {
            // Try to access the current value
            let images = try selectedImages.value()
            let imagesToData = images.map{ $0.toData() }
            
            useCase.addPost(travelId: log.id, text: text, images: imagesToData)
                .subscribe { _ in
                    self.finished.accept(true)
                }
                .disposed(by: disposeBag)

        } catch {
            print("Error getting value: \(error)")
        }

    }
}
