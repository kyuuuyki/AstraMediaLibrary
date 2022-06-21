//
//  MainViewController.swift
//  AstraMediaLibrary
//

import AVKit
import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - DISPLAY LOGIC
protocol MainViewControllerProtocol: AnyObject {
	func displaySessionStatus(viewModel: MainModel.SessionStatus.ViewModel)
	func displayAstronomyPictureOfTheDay(viewModel: MainModel.AstronomyPictureOfTheDay.ViewModel)
	func displaySuggestedCategoryList(viewModel: MainModel.SuggestedCategoryList.ViewModel)
	func displayRecentMediaList(viewModel: MainModel.RecentMediaList.ViewModel)
	func displaySelectAPOD(viewModel: MainModel.SelectAPOD.ViewModel)
	func displaySelectCategory(viewModel: MainModel.SelectCategory.ViewModel)
	func displaySelectMedia(viewModel: MainModel.SelectMedia.ViewModel)
}

// MARK: - VIEW CONTROLLER
class MainViewController:
	KSPCollectionViewCompositionalLayoutController,
	MainViewControllerProtocol
{
	var interactor: MainInteractorProtocol?
	var router: MainRouterProtocol?
	
	// MARK: MODEL
	var isFetchingData = false
	
	// MARK: VIEW
	// swiftlint:disable:next private_outlet
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet private weak var menuButtonContainerView: UIView!
	
	// MARK: VIEW MODEL
	var astronomyPictureOfTheDayViewModel: MainModel.AstronomyPictureOfTheDay.ViewModel? {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	var suggestedCategoryListViewModel: MainModel.SuggestedCategoryList.ViewModel? {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	var recentMediaListViewModel: MainModel.RecentMediaList.ViewModel? {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	// MARK: VIEW LIFECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		initMainViewController()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
		navigationController?.navigationBar.prefersLargeTitles = false
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	// MARK: ACTIONS
	@IBAction private func didTapOnMenuButton(_ sender: Any) {
		didTapOnMenuButton()
	}
}

// MARK: - SESSION STATUS
extension MainViewController {
	func getSessionStatus() {
		let request = MainModel.SessionStatus.Request()
		interactor?.getSessionStatus(request: request)
	}
	
	func displaySessionStatus(viewModel: MainModel.SessionStatus.ViewModel) {
		if viewModel.shouldDisplaySignIn {
			router?.navigateToSignIn()
		}
		
		fetchData()
	}
}

// MARK: - ASTRONOMY PICTURE OF THE DAY
extension MainViewController {
	func getAstronomyPictureOfTheDay() {
		let request = MainModel.AstronomyPictureOfTheDay.Request()
		interactor?.getAstronomyPictureOfTheDay(request: request)
	}
	
	func displayAstronomyPictureOfTheDay(viewModel: MainModel.AstronomyPictureOfTheDay.ViewModel) {
		endRefreshing { [weak self] in
			guard let self = self else { return }
			self.astronomyPictureOfTheDayViewModel = viewModel
		}
	}
}

// MARK: - SUGGESTED CATEGORY LIST
extension MainViewController {
	func getSuggestedCategoryList() {
		let request = MainModel.SuggestedCategoryList.Request()
		interactor?.getSuggestedCategoryList(request: request)
	}
	
	func displaySuggestedCategoryList(viewModel: MainModel.SuggestedCategoryList.ViewModel) {
		suggestedCategoryListViewModel = viewModel
	}
}

// MARK: - RECENT MEDIA LIST
extension MainViewController {
	func getRecentMediaList() {
		let request = MainModel.RecentMediaList.Request()
		interactor?.getRecentMediaList(request: request)
	}
	
	func displayRecentMediaList(viewModel: MainModel.RecentMediaList.ViewModel) {
		recentMediaListViewModel = viewModel
	}
}

// MARK: - SELECT APOD
extension MainViewController {
	func selectAPOD() {
		let request = MainModel.SelectAPOD.Request()
		interactor?.selectAPOD(request: request)
	}
	
	func displaySelectAPOD(viewModel: MainModel.SelectAPOD.ViewModel) {
		router?.navigateToMediaDetailView(item: viewModel.item)
	}
}

// MARK: - SELECT CATEGORY
extension MainViewController {
	func selectCategory(index: Int, isMission: Bool) {
		let request = MainModel.SelectCategory.Request(index: index, isMission: isMission)
		interactor?.selectCategory(request: request)
	}
	
	func displaySelectCategory(viewModel: MainModel.SelectCategory.ViewModel) {
		router?.navigateToMediaListView(category: viewModel.category)
	}
}

// MARK: - SELECT MEDIA
extension MainViewController {
	func selectMedia(index: Int) {
		let request = MainModel.SelectMedia.Request(index: index)
		interactor?.selectMedia(request: request)
	}
	
	func displaySelectMedia(viewModel: MainModel.SelectMedia.ViewModel) {
		router?.navigateToMediaDetailView(item: viewModel.item)
	}
}

// MARK: - PRIVATE EXTENSION
extension MainViewController {
	// MARK: INIT
	func initMainViewController() {
		title = "Home"
		menuButtonContainerView.backgroundColor = .clear
		menuButtonContainerView.insertBlurredBackground(withStyle: .systemChromeMaterialLight)
		menuButtonContainerView.circle()
		
		configureCollectionView()
		configureCollectionViewLayout()
		
		getSessionStatus()
	}
	
	func fetchData() {
		isFetchingData = true
		getAstronomyPictureOfTheDay()
		getSuggestedCategoryList()
		getRecentMediaList()
	}
	
	func didTapOnMenuButton() {
		router?.navigateToMenu()
	}
}
