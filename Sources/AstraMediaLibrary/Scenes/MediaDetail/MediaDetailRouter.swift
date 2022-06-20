//
//  MediaDetailRouter.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - ROUTING LOGIC
protocol MediaDetailRouterProtocol {
	func navigateToSafari(url: URL)
	func navigateBack()
}

// MARK: - ROUTER
struct MediaDetailRouter: MediaDetailRouterProtocol {
    weak var viewController: UIViewController?
	let transitionCoordinator: TransitionCoordinatorProtocol
	
	func performNavigation(_ type: NavigationType, animated: Bool, completion: (() -> Void)?) {
		transitionCoordinator.performNavigation(type, animated: animated, completion: completion)
	}
}

extension MediaDetailRouter {
	func navigateToSafari(url: URL) {
		if let viewController = viewController as? MediaDetailViewController {
			viewController.playerViewController?.player?.pause()
		}
		
		performNavigation(
			.safari(url: url),
			animated: true,
			completion: nil
		)
	}
	
	func navigateBack() {
		performNavigation(.back, animated: true, completion: nil)
	}
}
