//
//  MainRouter.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - ROUTING LOGIC
protocol MainRouterProtocol {
	func navigateToMenu()
	func navigateToSignIn()
	func navigateToSignUp()
	func navigateToMediaDetailView(item: MediaLibraryItemProtocol)
	func navigateToMediaListView(category: MediaLibraryCategoryProtocol)
}

// MARK: - ROUTER
struct MainRouter: MainRouterProtocol {
	weak var viewController: UIViewController?
	var transitionCoordinator: TransitionCoordinatorProtocol
	
	func performNavigation(_ type: NavigationType, animated: Bool, completion: (() -> Void)?) {
		transitionCoordinator.performNavigation(type, animated: animated, completion: completion)
	}
}

extension MainRouter {
	func navigateToMenu() {
		performNavigation(
			.menu,
			animated: true,
			completion: nil
		)
	}
	
	func navigateToSignIn() {
		performNavigation(
			.presentAndPush(sceneName: "AstraAuthentication.SignIn", parameters: nil),
			animated: true,
			completion: nil
		)
	}
	
	func navigateToSignUp() {
		performNavigation(
			.presentAndPush(sceneName: "AstraAuthentication.SignUp", parameters: nil),
			animated: true,
			completion: nil
		)
	}
	
	func navigateToMediaDetailView(item: MediaLibraryItemProtocol) {
		performNavigation(
			.push(sceneName: MediaDetailSceneModule.moduleName, parameters: ["item": item]),
			animated: true,
			completion: nil
		)
	}
	
	func navigateToMediaListView(category: MediaLibraryCategoryProtocol) {
		performNavigation(
			.push(
				sceneName: MediaListSceneModule.moduleName,
				parameters: ["category": category]
			),
			animated: true,
			completion: nil
		)
	}
}
