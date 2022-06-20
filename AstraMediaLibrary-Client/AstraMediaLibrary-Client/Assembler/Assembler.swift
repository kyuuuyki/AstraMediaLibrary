//
//  Assembler.swift
//  AstraMediaLibrary-Client
//

import AstraCoreAPI
import AstraCoreModels
import AstraMediaLibrary
import Foundation
import KyuGenericExtensions
import UIKit

public final class Assembler: AssemblerProtocol {
	// MARK: Public
	public static func assembler() -> AssemblerProtocol {
		return self.shared
	}
	
	public let container: ContainerProtocol = Container()
	
	// MARK: Private
	private init() {}
	private static let shared = Assembler()
}

public extension Assembler {
	func configure(window: UIWindow?) {
		let authenticationService = AstraCoreAPI.coreAPI().authenticationService()
		let mediaLibraryService = AstraCoreAPI.coreAPI().mediaLibraryService()
		let transitionCoordinator = TransitionCoordinator()
		
		// MARK: Services
		container.register(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) { _ in
			return transitionCoordinator
		}
		
		container.register(AuthenticationServiceProtocol.self) { _ in
			return authenticationService
		}
		
		container.register(MediaLibraryServiceProtocol.self) { _ in
			return mediaLibraryService
		}
		
		// MARK: Scenes
		guard let transitionCoordinator = resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) else {
			return
		}
		
		guard let mediaLibraryService = resolver.resolve(
			MediaLibraryServiceProtocol.self
		) else {
			return
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: MainSceneModule.moduleName
		) { _ in
			return MainSceneModule(
				transitionCoordinator: transitionCoordinator,
				authenticationService: authenticationService,
				mediaLibraryService: mediaLibraryService
			)
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: MediaListSceneModule.moduleName
		) { _ in
			return MediaListSceneModule(
				transitionCoordinator: transitionCoordinator,
				mediaLibraryService: mediaLibraryService
			)
		}
		
		container.register(SceneModuleProtocol.self, name: MediaDetailSceneModule.moduleName) { _ in
			return MediaDetailSceneModule(
				transitionCoordinator: transitionCoordinator,
				mediaLibraryService: mediaLibraryService
			)
		}
		
		configureRootViewController(window: window)
	}
}

private extension Assembler {
	func configureRootViewController(window: UIWindow?) {
		let startSceneModule = resolver.resolve(
			SceneModuleProtocol.self,
			name: MainSceneModule.moduleName
		)
		
		guard let startViewController = startSceneModule?.build(with: nil) else { return }
		let navigationController = UINavigationController(rootViewController: startViewController)
		
		window?.rootViewController = navigationController
	}
}
