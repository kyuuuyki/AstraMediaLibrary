//
//  MediaDetailSceneModule.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

public struct MediaDetailSceneModule: SceneModuleProtocol {
	public static var moduleName: String = "AstraMediaLibrary.MediaDetail"
	public var nibName = String(describing: MediaDetailViewController.self)
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
        let viewController = MediaDetailViewController(nibName: nibName, bundle: bundle)
		
		guard let item = parameters?["item"] as? MediaLibraryItemProtocol else {
			return nil
		}
        
		let dataStore = MediaDetailDataStore(item: item)
		let worker = MediaDetailWorker(mediaLibraryService: mediaLibraryService)
        let presenter = MediaDetailPresenter(viewController: viewController)
        let interactor = MediaDetailInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		let router = MediaDetailRouter(
			viewController: viewController,
			transitionCoordinator: transitionCoordinator
		)
        
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
