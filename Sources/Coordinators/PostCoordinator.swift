//
//  PostCoordinator.swift
//  App
//
//  Created by 김도경 on 7/17/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit
import PhotosUI

final public class PostCoordinator : Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?
    
    private var navigationController : UINavigationController
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log){
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let useCase = DIContainer.shared.resolve(PostUseCase.self)!
        let viewModel = PostListViewmodel(postUseCase: useCase, log: self.log)
        let viewController = PostListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
        viewController.coordinator = self
    }
}

extension PostCoordinator : PostListViewControllerDelgate{
    
    func navigateToAddPost() {
        let useCase = DIContainer.shared.resolve(PostUseCase.self)!
        let viewModel = AddPostViewModel(useCase: useCase, log: self.log)
        let viewController = AddPostViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(viewController, animated: true)
        viewController.coordinator = self
    }
    
    func navigateToDetailPost(_ postId: Int) {
        let useCase = DIContainer.shared.resolve(PostUseCase.self)!
        let viewModel = PostDetailViewModel(postUseCase: useCase, postId: postId, log: self.log)
        let viewController = DetailPostViewController(viewModel: viewModel)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension PostCoordinator : DetailPostViewControllerDelgate {
    public func openCommentSheet(_ post : Post) {
        let viewModel = PostCommentViewModel(post: post)
        let viewController = PostCommentSheet(viewModel: viewModel)
        
        //모달 사이즈 설정
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return UIScreen.main.bounds.height / 2
        }
        
        if let sheet = viewController.sheetPresentationController{
            sheet.detents = [smallDetent]
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 25
            self.navigationController.present(viewController, animated: true)
        }
    }
}

extension PostCoordinator : AddPostViewControllerDelgate {
    public func showPhotoPicker(_ viewController : PHPickerViewControllerDelegate) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 7
        configuration.selection = .ordered
        configuration.preselectedAssetIdentifiers = []
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = viewController
        self.navigationController.present(picker, animated: true)
    }
    
    public func dismissView() {
        self.navigationController.popViewController(animated: true)
    }
}
