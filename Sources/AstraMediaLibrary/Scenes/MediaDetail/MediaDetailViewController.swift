//
//  MediaDetailViewController.swift
//  AstraMediaLibrary
//

import AVKit
import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - DISPLAY LOGIC
protocol MediaDetailViewControllerProtocol: AnyObject {
	func displayMediaDetail(viewModel: MediaDetailModel.MediaDetail.ViewModel)
}

// MARK: - VIEW CONTROLLER
class MediaDetailViewController:
	KSPCollectionViewCompositionalLayoutController,
	MediaDetailViewControllerProtocol,
	UIGestureRecognizerDelegate
{
	var interactor: MediaDetailInteractorProtocol?
	var router: MediaDetailRouterProtocol?
	
	// MARK: MODEL
	var playerViewController: AVPlayerViewController?
	
	private var gestureRecognizerDelegate: UIGestureRecognizerDelegate?
	
	// MARK: VIEW
	// swiftlint:disable:next private_outlet
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet private weak var backButtonContainerView: UIView!
	
	// MARK: VIEW MODEL
	var mediaDetailViewModel: MediaDetailModel.MediaDetail.ViewModel? {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	// MARK: VIEW LIFECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		initMediaDetailViewController()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		gestureRecognizerDelegate = navigationController?.interactivePopGestureRecognizer?.delegate
		
		navigationController?.isNavigationBarHidden = true
		navigationController?.interactivePopGestureRecognizer?.delegate = self
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.interactivePopGestureRecognizer?.delegate = gestureRecognizerDelegate
		navigationController?.isNavigationBarHidden = false
	}
	
	deinit {
		playerViewController?.removeFromParent()
		playerViewController?.player?.pause()
		playerViewController?.player?.replaceCurrentItem(with: nil)
		playerViewController = nil
	}
	
	// MARK: ACTION
	@IBAction private func didTapOnBackButton(_ sender: Any) {
		router?.navigateBack()
	}
	
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return navigationController?.viewControllers.count ?? 0 > 1
	}
}

// MARK: - MEDIA DETAIL
extension MediaDetailViewController {
	func getMediaDetail() {
		let request = MediaDetailModel.MediaDetail.Request()
		interactor?.getMediaDetail(request: request)
	}
	
	func displayMediaDetail(viewModel: MediaDetailModel.MediaDetail.ViewModel) {
		mediaDetailViewModel = viewModel
	}
}

// MARK: - PRIVATE EXTENSION
private extension MediaDetailViewController {
	// MARK: INIT
	func initMediaDetailViewController() {
		backButtonContainerView.insertBlurredBackground(withStyle: DesignSystem.Effect.blurStyle)
		backButtonContainerView.circle()
		
		configureCollectionView()
		configureAVPlayerViewController()
		configureCollectionViewLayout()
		
		getMediaDetail()
	}
}
