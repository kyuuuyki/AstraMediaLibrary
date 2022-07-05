//
//  Assembler+MediaLibrary.swift
//  AstraMediaLibrary-Client
//

import AstraCoreAPI
import AstraCoreModels
import AstraMediaLibrary
import Foundation
import KyuGenericExtensions

extension Assembler {
	func configureMediaLibrary() {
		// MARK: Resolving
		guard let transitionCoordinator = resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) else {
			return
		}
		
		guard let authenticationService = resolver.resolve(
			AuthenticationServiceProtocol.self,
			name: AuthenticationService.moduleName
		) else {
			return
		}
		
		guard let mediaLibraryService = resolver.resolve(
			MediaLibraryServiceProtocol.self,
			name: MediaLibraryService.moduleName
		) else {
			return
		}
		
		// MARK: Registration
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
	}
}
