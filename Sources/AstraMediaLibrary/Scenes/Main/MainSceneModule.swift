//
//  MainSceneModule.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

public struct MainSceneModule: SceneModuleProtocol {
	public static var moduleName: String = "AstraMediaLibrary.Main"
	public var nibName = String(describing: MainViewController.self)
	public var bundle: Bundle? = .module
	
	private let transitionCoordinator: TransitionCoordinatorProtocol
	private let authenticationService: AuthenticationServiceProtocol
	private let mediaLibraryService: MediaLibraryServiceProtocol
	private let userService: UserServiceProtocol
	
	public init(
		transitionCoordinator: TransitionCoordinatorProtocol,
		authenticationService: AuthenticationServiceProtocol,
		mediaLibraryService: MediaLibraryServiceProtocol,
		userService: UserServiceProtocol
	) {
		self.transitionCoordinator = transitionCoordinator
		self.authenticationService = authenticationService
		self.mediaLibraryService = mediaLibraryService
		self.userService = userService
	}
    
	public func build(with parameters: [String: Any]?) -> UIViewController? {
        let viewController = MainViewController(nibName: nibName, bundle: bundle)
        
        let dataStore = MainDataStore()
		let worker = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService,
			userService: userService
		)
        let presenter = MainPresenter(viewController: viewController)
        let interactor = MainInteractor(presenter: presenter, worker: worker, dataStore: dataStore)
        let router = MainRouter(
			viewController: viewController,
			transitionCoordinator: transitionCoordinator
		)
        
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
