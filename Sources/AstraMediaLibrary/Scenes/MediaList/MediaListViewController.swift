//
//  MediaListViewController.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - DISPLAY LOGIC
protocol MediaListViewControllerProtocol: AnyObject {
	func displayMediaListAppearance(viewModel: MediaListModel.MediaListAppearance.ViewModel)
	func displayMediaList(viewModel: MediaListModel.MediaList.ViewModel)
	func displaySelectMedia(viewModel: MediaListModel.SelectMedia.ViewModel)
}

// MARK: - VIEW CONTROLLER
class MediaListViewController:
	KSPCollectionViewCompositionalLayoutController,
	MediaListViewControllerProtocol
{
	var interactor: MediaListInteractorProtocol?
	var router: MediaListRouterProtocol?
	
	// MARK: MODEL
	private var searchController: UISearchController?
	
	// MARK: VIEW
	// swiftlint:disable:next private_outlet
	@IBOutlet weak var collectionView: UICollectionView!
	
	// MARK: VIEW MODEL
	var mediaListAppearanceViewModel: MediaListModel.MediaListAppearance.ViewModel? {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	var mediaListViewModel: MediaListModel.MediaList.ViewModel? {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	var shouldDisplayActivityIndicator = false {
		didSet {
			configureCollectionViewLayout()
		}
	}
	
	// MARK: VIEW LIFECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.hidesSearchBarWhenScrolling = false
		initMediaListViewController()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationItem.hidesSearchBarWhenScrolling = true
		focusAtSearchBarIfNeeded()
	}
	
	// MARK: ACTION
}

// MARK: - MEDIA LIST APPEARANCE
extension MediaListViewController {
	func getMediaListAppearance() {
		let request = MediaListModel.MediaListAppearance.Request()
		interactor?.getMediaListAppearance(request: request)
	}
	
	func displayMediaListAppearance(viewModel: MediaListModel.MediaListAppearance.ViewModel) {
		mediaListAppearanceViewModel = viewModel
		
		title = viewModel.title
		
		if viewModel.shouldDisplaySearchBar {
			configureSearchBar()
		}
		
		if let keyword = viewModel.keyword {
			searchController?.searchBar.text = keyword
			getMediaList(keyword: keyword)
		}
	}
}

// MARK: - MEDIA LIST
extension MediaListViewController {
	func getMediaList(keyword: String) {
		shouldDisplayActivityIndicator = true
		
		let request = MediaListModel.MediaList.Request(keyword: keyword)
		interactor?.getMediaList(request: request)
	}
	
	func displayMediaList(viewModel: MediaListModel.MediaList.ViewModel) {
		shouldDisplayActivityIndicator = false
		mediaListViewModel = viewModel
	}
}

// MARK: - SELECT MEDIA
extension MediaListViewController {
	func selectMedia(index: Int) {
		let request = MediaListModel.SelectMedia.Request(index: index)
		interactor?.selectMedia(request: request)
	}
	
	func displaySelectMedia(viewModel: MediaListModel.SelectMedia.ViewModel) {
		router?.navigateToMediaDetail(item: viewModel.item)
	}
}

// MARK: - PRIVATE EXTENSION
private extension MediaListViewController {
	// MARK: INIT
	func initMediaListViewController() {
		configureCollectionView()
		configureCollectionViewLayout()
		
		getMediaListAppearance()
	}
}

// MARK: - UISEARCHBAR DELEGATE
extension MediaListViewController: UISearchBarDelegate {
	func configureSearchBar() {
		searchController = UISearchController(searchResultsController: nil)
		searchController?.searchBar.autocapitalizationType = .none
		searchController?.obscuresBackgroundDuringPresentation = true
		searchController?.searchBar.delegate = self
		
		navigationItem.searchController = searchController
	}
	
	func focusAtSearchBarIfNeeded() {
		guard mediaListViewModel == nil else { return }
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.searchController?.searchBar.becomeFirstResponder()
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let keyword = searchBar.text else { return }
		getMediaList(keyword: keyword)
		
		searchController?.isActive = false
		searchController?.searchBar.text = keyword
	}
}
