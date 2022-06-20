//
//  MediaListRouter.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - ROUTING LOGIC
protocol MediaListRouterProtocol {
	func navigateToSafari(url: URL)
	func navigateToMediaDetail(item: MediaLibraryItemProtocol)
}

// MARK: - ROUTER
struct MediaListRouter: MediaListRouterProtocol {
    weak var viewController: UIViewController?
	var transitionCoordinator: TransitionCoordinatorProtocol
	
	func performNavigation(_ type: NavigationType, animated: Bool, completion: (() -> Void)?) {
		transitionCoordinator.performNavigation(type, animated: animated, completion: completion)
	}
}

extension MediaListRouter {
	func navigateToSafari(url: URL) {
		performNavigation(
			.safari(url: url),
			animated: true,
			completion: nil
		)
	}
	
	func navigateToMediaDetail(item: MediaLibraryItemProtocol) {
		performNavigation(
			.push(sceneName: MediaDetailSceneModule.moduleName, parameters: ["item": item]),
			animated: true,
			completion: nil
		)
	}
}
