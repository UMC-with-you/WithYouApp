//
//  CreateRewindCoordinator.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import Foundation
import UIKit

final public class CreateRewindCoordinator : Coordinator {
    
    private var navigationController: UINavigationController
    
    public var childCoordinators: [Coordinator] = []
    public var parentCoordiantor: Coordinator?
    
    private let log : Log
    
    public init(navigationController : UINavigationController, log : Log) {
        self.navigationController = navigationController
        self.log = log
    }
    
    public func start() {
        let rewindUseCase = DIContainer.shared.resolve(RewindUseCase.self)!
        let logUseCase = DIContainer.shared.resolve(LogUseCase.self)!
        let viewModel = CreateTravelRewindViewModel(log: log, rewindUseCase: rewindUseCase, logUseCase: logUseCase)
        let viewController = CreateTravelRewindViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(viewController, animated: true)
        viewController.coordinator = self
    }
}

extension CreateRewindCoordinator : CreateTravelViewControllerDelgate {
    func openMoodPopup(_ delegate : MoodPopupDelegate) {
        let popUp = MoodPopupViewController()
        popUp.modalPresentationStyle = .overFullScreen
        self.navigationController.present(popUp, animated: true)
        popUp.delegate = delegate
    }
}
