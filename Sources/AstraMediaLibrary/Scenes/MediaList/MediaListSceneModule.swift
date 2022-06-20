//
//  MediaListSceneModule.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

public struct MediaListSceneModule: SceneModuleProtocol {
	public static var moduleName: String = "AstraMediaLibrary.MediaList"
	public var nibName = String(describing: MediaListViewController.self)
	public var bundle: Bundle? = .module
	
	private let transitionCoordinator: TransitionCoordinatorProtocol
	private let mediaLibraryService: MediaLibraryServiceProtocol
	
	public init(
		transitionCoordinator: TransitionCoordinatorProtocol,
		mediaLibraryService: MediaLibraryServiceProtocol
	) {
		self.transitionCoordinator = transitionCoordinator
		self.mediaLibraryService = mediaLibraryService
	}
    
	public func build(with parameters: [String: Any]?) -> UIViewController? {
        let viewController = MediaListViewController(nibName: nibName, bundle: bundle)
		
		let category = parameters?["category"] as? MediaLibraryCategoryProtocol
		
		let dataStore = MediaListDataStore(category: category)
		let worker = MediaListWorker(mediaLibraryService: mediaLibraryService)
        let presenter = MediaListPresenter(viewController: viewController)
        let interactor = MediaListInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
        let router = MediaListRouter(
			viewController: viewController,
			transitionCoordinator: transitionCoordinator
		)
        
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
