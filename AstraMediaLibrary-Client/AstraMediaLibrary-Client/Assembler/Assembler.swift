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
		configureServices()
		configureMediaLibrary()
		configureRootViewController(window: window)
	}
}

private extension Assembler {
	func configureServices() {
		container.register(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) { _ in
			return TransitionCoordinator()
		}
		
		container.register(
			MediaLibraryServiceProtocol.self,
			name: MediaLibraryService.moduleName
		) { _ in
			let apiKey = AstraCoreAPI.coreAPI().userSecret?.dataGovAPIKey ?? "DEMO_KEY"
			return MediaLibraryService(apiKey: apiKey)
		}
	}
	
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
