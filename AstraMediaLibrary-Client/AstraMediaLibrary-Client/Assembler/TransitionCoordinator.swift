//
//  TransitionCoordinator.swift
//  AstraMediaLibrary-Client
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import SafariServices
import UIKit

public struct TransitionCoordinator: TransitionCoordinatorProtocol {
	public static var moduleName: String = "Service.Router.TransitionCoordinator"
	public var resolver: ResolverProtocol {
		Assembler.assembler().resolver
	}
	
	public func performNavigation(
		_ type: Any,
		animated: Bool,
		completion: (() -> Void)?
	) {
		guard let type = type as? NavigationType,
			  let presentingViewController = UIApplication.topViewController()
		else {
			return
		}
		
		switch type {
		case .present(let sceneName, let parameters):
			guard let viewController = resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			
			presentingViewController.present(
				viewController,
				animated: animated,
				completion: completion
			)
			
		case .push(let sceneName, let parameters):
			guard let viewController = resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			
			presentingViewController.navigationController?.pushViewController(
				viewController,
				animated: animated
			)
			completion?()
			
		case .presentAndPush(let sceneName, let parameters):
			guard let viewController = resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			
			let navigationController = UINavigationController(rootViewController: viewController)
			presentingViewController.present(
				navigationController,
				animated: animated,
				completion: completion
			)
			
		case .popToScene(let sceneName):
			guard let viewController = resolveExistingScene(sceneName: sceneName) else { return }
			presentingViewController.navigationController?.popToViewController(
				viewController,
				animated: animated
			)
			completion?()
			
		case .back:
			guard let navigationController = presentingViewController.navigationController else {
				presentingViewController.dismiss(animated: animated, completion: completion)
				return
			}
			
			if navigationController.viewControllers.count > 1 {
				navigationController.popViewController(animated: animated)
				completion?()
			} else {
				navigationController.dismiss(animated: animated, completion: completion)
			}
			
		case .reset:
			Assembler.assembler().reconfigure()
			
		case .menu:
			break
			
		case .safari(let url):
			let viewController = SFSafariViewController(url: url)
			viewController.modalPresentationStyle = .pageSheet
			UIApplication.application().window?.rootViewController?.present(
				viewController,
				animated: true
			)
		}
	}
}

private extension TransitionCoordinator {
	func resolveExistingScene(sceneName: String) -> UIViewController? {
		if let presentingViewController = UIApplication.topViewController(),
		   let sceneModule = resolver.resolve(SceneModuleProtocol.self, name: sceneName),
		   let existingViewController = presentingViewController
			.navigationController?
			.viewControllers
			.first(where: { $0.nibName == sceneModule.nibName }) {
			return existingViewController
		} else {
			return nil
		}
	}
}
