//
//  MainViewControllerTests.swift
//  AstraMediaLibrary
//

import AstraCoreModels
@testable import AstraMediaLibrary
import XCTest

// MARK: - VIEW CONTROLLER
class MainViewControllerTests: XCTestCase {
	private static var moduleName: String = "Main"
	private var nibName = String(describing: MainViewController.self)
	private var bundle: Bundle? = .module
	
	// MARK: SUBJECT UNDER TEST
	private var sut: MainViewController!
	private var window: UIWindow!
	
	// MARK: TEST LIFECYCLE
	override func setUp() {
		super.setUp()
		window = UIWindow()
		setupMainViewController()
	}
	
	override func tearDown() {
		window = nil
		super.tearDown()
	}
	
	// MARK: TEST SETUP
	private func setupMainViewController() {
		sut = MainViewController(nibName: nibName, bundle: bundle)
	}
	
	private func loadView() {
		window.addSubview(sut.view)
		RunLoop.current.run(until: Date())
	}
	
	// MARK: TEST DOUBLES
	private class MainInteractorSpy: MainInteractorProtocol {
		var getSessionStatusCalled = false
		var getSessionStatusRequest: MainModel.SessionStatus.Request!
		func getSessionStatus(request: MainModel.SessionStatus.Request) {
			getSessionStatusCalled = true
			getSessionStatusRequest = request
		}
		
		var selectAPODCalled = false
		var selectAPODRequest: MainModel.SelectAPOD.Request!
		func selectAPOD(request: MainModel.SelectAPOD.Request) {
			selectAPODCalled = true
			selectAPODRequest = request
		}
		
		var getAstronomyPictureOfTheDayCalled = false
		var getAstronomyPictureOfTheDayRequest: MainModel.AstronomyPictureOfTheDay.Request!
		func getAstronomyPictureOfTheDay(request: MainModel.AstronomyPictureOfTheDay.Request) {
			getAstronomyPictureOfTheDayCalled = true
			getAstronomyPictureOfTheDayRequest = request
		}
		
		var getSuggestedCategoryListCalled = false
		var getSuggestedCategoryListRequest: MainModel.SuggestedCategoryList.Request!
		func getSuggestedCategoryList(request: MainModel.SuggestedCategoryList.Request) {
			getSuggestedCategoryListCalled = true
			getSuggestedCategoryListRequest = request
		}
		
		var getRecentMediaListCalled = false
		var getRecentMediaListRequest: MainModel.RecentMediaList.Request!
		func getRecentMediaList(request: MainModel.RecentMediaList.Request) {
			getRecentMediaListCalled = true
			getRecentMediaListRequest = request
		}
		
		var selectCategoryCalled = false
		var selectCategoryRequest: MainModel.SelectCategory.Request!
		func selectCategory(request: MainModel.SelectCategory.Request) {
			selectCategoryCalled = true
			selectCategoryRequest = request
		}
		
		var selectMediaCalled = false
		var selectMediaRequest: MainModel.SelectMedia.Request!
		func selectMedia(request: MainModel.SelectMedia.Request) {
			selectMediaCalled = true
			selectMediaRequest = request
		}
	}
	
	private class MainRouterSpy: MainRouterProtocol {
		var navigateToMenuCalled = false
		func navigateToMenu() {
			navigateToMenuCalled = true
		}
		
		var navigateToSignInCalled = false
		func navigateToSignIn() {
			navigateToSignInCalled = true
		}
		
		var navigateToMediaDetailViewCalled = false
		func navigateToMediaDetailView(item: MediaLibraryItemProtocol) {
			navigateToMediaDetailViewCalled = true
		}
		
		var navigateToMediaListViewCalled = false
		func navigateToMediaListView(category: MediaLibraryCategoryProtocol) {
			navigateToMediaListViewCalled = true
		}
	}
}

// MARK: - TEST ACTIONS
extension MainViewControllerTests {
	func testDidTapOnMenuButton() {
		// Given
		let router = MainRouterSpy()
		sut.router = router
		
		// When
		sut.didTapOnMenuButton()
		
		// Then
		XCTAssertTrue(router.navigateToMenuCalled)
	}
}

// MARK: - TEST SESSION STATUS
extension MainViewControllerTests {
	func testGetSessionStatus() {
		// Given
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.getSessionStatus()
		
		// Then
		XCTAssertTrue(interactor.getSessionStatusCalled)
	}
	
	func testDisplaySessionStatus_SignedIn() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let viewModel = MainModel.SessionStatus.ViewModel(shouldDisplaySignIn: false)
		
		// When
		sut.displaySessionStatus(viewModel: viewModel)
		
		// Then
		XCTAssertTrue(sut.isFetchingData)
		XCTAssertTrue(interactor.getAstronomyPictureOfTheDayCalled)
		XCTAssertTrue(interactor.getSuggestedCategoryListCalled)
		XCTAssertTrue(interactor.getRecentMediaListCalled)
	}
	
	func testDisplaySessionStatus_SignedOut() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let router = MainRouterSpy()
		sut.router = router
		
		let viewModel = MainModel.SessionStatus.ViewModel(shouldDisplaySignIn: true)
		
		// When
		sut.displaySessionStatus(viewModel: viewModel)
		
		// Then
		XCTAssertTrue(sut.isFetchingData)
		XCTAssertTrue(interactor.getAstronomyPictureOfTheDayCalled)
		XCTAssertTrue(interactor.getSuggestedCategoryListCalled)
		XCTAssertTrue(interactor.getRecentMediaListCalled)
		XCTAssertTrue(router.navigateToSignInCalled)
	}
}

// MARK: - TEST ASTRONOMY PICTURE OF THE DAY
extension MainViewControllerTests {
	func testGetAstronomyPictureOfTheDay() {
		// Given
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.getAstronomyPictureOfTheDay()
		
		// Then
		XCTAssertTrue(interactor.getAstronomyPictureOfTheDayCalled)
	}
	
	func testDisplayAstronomyPictureOfTheDay() {
		// Given
		loadView()
		
		let expectation = XCTestExpectation()
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			expectation.fulfill()
		}
		
		let apodItem = MediaLibraryAPODItemMock()
		let viewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(apodItem: apodItem)
		
		// When
		sut.displayAstronomyPictureOfTheDay(viewModel: viewModel)
		
		// Then
		wait(
			for: [expectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertEqual(
			sut.astronomyPictureOfTheDayViewModel?.apodItem as? MediaLibraryAPODItemMock,
			apodItem
		)
	}
}

// MARK: - TEST SUGGESTED CATEGORY LIST
extension MainViewControllerTests {
	func testGetSuggestedCategoryList() {
		// Given
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.getSuggestedCategoryList()
		
		// Then
		XCTAssertTrue(interactor.getSuggestedCategoryListCalled)
	}
	
	func testDisplaySuggestedCategoryList() {
		// Given
		loadView()
		
		let agency = MediaLibraryCategoryAgencyMock()
		let mission = MediaLibraryCategoryMissionMock()
		let viewModel = MainModel.SuggestedCategoryList.ViewModel(
			agencies: [agency],
			missions: [mission]
		)
		
		// When
		sut.displaySuggestedCategoryList(viewModel: viewModel)
		
		// Then
		XCTAssertEqual(
			sut.suggestedCategoryListViewModel?.agencies.first as? MediaLibraryCategoryAgencyMock,
			agency
		)
		XCTAssertEqual(
			sut.suggestedCategoryListViewModel?.missions.first as? MediaLibraryCategoryMissionMock,
			mission
		)
	}
}

// MARK: - TEST RECENT MEDIA LIST
extension MainViewControllerTests {
	func testGetRecentMediaList() {
		// Given
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.getRecentMediaList()
		
		// Then
		XCTAssertTrue(interactor.getRecentMediaListCalled)
	}
	
	func testDisplayRecentMediaList() {
		// Given
		loadView()
		
		let item = MediaLibraryItemMock()
		let viewModel = MainModel.RecentMediaList.ViewModel(items: [item])
		
		// When
		sut.displayRecentMediaList(viewModel: viewModel)
		
		// Then
		XCTAssertEqual(
			sut.recentMediaListViewModel?.items.first as? MediaLibraryItemMock,
			item
		)
	}
}

// MARK: - TEST SELECT APOD
extension MainViewControllerTests {
	func testSelectAPOD() {
		// Given
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.selectAPOD()
		
		// Then
		XCTAssertTrue(interactor.selectAPODCalled)
	}
	
	func testDisplaySelectAPOD() {
		// Given
		loadView()
		
		let router = MainRouterSpy()
		sut.router = router
		
		let apodItem = MediaLibraryAPODItemMock()
		let item = APODItem(apodItem: apodItem)
		let viewModel = MainModel.SelectAPOD.ViewModel(item: item)
		
		// When
		sut.displaySelectAPOD(viewModel: viewModel)
		
		// Then
		XCTAssertTrue(router.navigateToMediaDetailViewCalled)
	}
}

// MARK: - TEST SELECT CATEGORY
extension MainViewControllerTests {
	func testSelectCategory() {
		// Given
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let index = 0
		let isMission = false
		
		// When
		sut.selectCategory(index: index, isMission: isMission)
		
		// Then
		XCTAssertTrue(interactor.selectCategoryCalled)
		XCTAssertEqual(interactor.selectCategoryRequest.index, index)
		XCTAssertEqual(interactor.selectCategoryRequest.isMission, isMission)
	}
	
	func testDisplaySelectCategory() {
		// Given
		loadView()
		
		let router = MainRouterSpy()
		sut.router = router
		
		let agency = MediaLibraryCategoryAgencyMock()
		let viewModel = MainModel.SelectCategory.ViewModel(category: agency)
		
		// When
		sut.displaySelectCategory(viewModel: viewModel)
		
		// Then
		XCTAssertTrue(router.navigateToMediaListViewCalled)
	}
}

// MARK: - TEST SELECT MEDIA
extension MainViewControllerTests {
	func testSelectMedia() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let index = 0
		
		// When
		sut.selectMedia(index: index)
		
		// Then
		XCTAssertTrue(interactor.selectMediaCalled)
		XCTAssertEqual(interactor.selectMediaRequest.index, index)
	}
	
	func testDisplaySelectMedia() {
		// Given
		loadView()
		
		let router = MainRouterSpy()
		sut.router = router
		
		let item = MediaLibraryItemMock()
		let viewModel = MainModel.SelectMedia.ViewModel(item: item)
		
		// When
		sut.displaySelectMedia(viewModel: viewModel)
		
		// Then
		XCTAssertTrue(router.navigateToMediaDetailViewCalled)
	}
}

// MARK: - TEST FUNCTIONALITY
extension MainViewControllerTests {
	func testInitMainViewController() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.initMainViewController()
		
		// Then
		XCTAssertTrue(interactor.getSessionStatusCalled)
	}
	
	func testFetchData() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		// When
		sut.fetchData()
		
		// Then
		XCTAssertTrue(sut.isFetchingData)
		XCTAssertTrue(interactor.getAstronomyPictureOfTheDayCalled)
		XCTAssertTrue(interactor.getSuggestedCategoryListCalled)
		XCTAssertTrue(interactor.getRecentMediaListCalled)
	}
}

// MARK: - TEST COLLECTIONVIEW
extension MainViewControllerTests {
	func testCollectionView_DidSelectItemAtIndexPath_APOD() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let collectionViewLayout = MainCompositionalLayoutMock()
		sut.collectionViewLayout = collectionViewLayout
		
		let sectionIndex = MainCompositionalLayoutMockSectionIndex.apod.rawValue
		let indexPath = IndexPath(item: 0, section: sectionIndex)
		
		// When
		sut.collectionView(sut.collectionView, didSelectItemAt: indexPath)
		
		// Then
		XCTAssertTrue(interactor.selectAPODCalled)
	}
	
	func testCollectionView_DidSelectItemAtIndexPath_Category_Agency() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let collectionViewLayout = MainCompositionalLayoutMock()
		sut.collectionViewLayout = collectionViewLayout
		
		let sectionIndex = MainCompositionalLayoutMockSectionIndex.categoryAgency.rawValue
		let indexPath = IndexPath(item: 0, section: sectionIndex)
		
		// When
		sut.collectionView(sut.collectionView, didSelectItemAt: indexPath)
		
		// Then
		XCTAssertTrue(interactor.selectCategoryCalled)
	}
	
	func testCollectionView_DidSelectItemAtIndexPath_Category_Mission() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let collectionViewLayout = MainCompositionalLayoutMock()
		sut.collectionViewLayout = collectionViewLayout
		
		let sectionIndex = MainCompositionalLayoutMockSectionIndex.categoryMission.rawValue
		let indexPath = IndexPath(item: 0, section: sectionIndex)
		
		// When
		sut.collectionView(sut.collectionView, didSelectItemAt: indexPath)
		
		// Then
		XCTAssertTrue(interactor.selectCategoryCalled)
	}
	
	func testCollectionView_DidSelectItemAtIndexPath_Media() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		let collectionViewLayout = MainCompositionalLayoutMock()
		sut.collectionViewLayout = collectionViewLayout
		
		let sectionIndex = MainCompositionalLayoutMockSectionIndex.media.rawValue
		let indexPath = IndexPath(item: 0, section: sectionIndex)
		
		// When
		sut.collectionView(sut.collectionView, didSelectItemAt: indexPath)
		
		// Then
		XCTAssertTrue(interactor.selectMediaCalled)
	}
}

// MARK: - TEST REFRESHCONTROL
extension MainViewControllerTests {
	func testEndRefreshing() {
		// Given
		loadView()
		
		let expectation = XCTestExpectation()
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			expectation.fulfill()
		}
		
		// When
		sut.endRefreshing {
			expectation.fulfill()
		}
		
		// Then
		wait(
			for: [expectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertFalse(sut.collectionView.refreshControl?.isRefreshing ?? true)
	}
	
	func testScrollView_DidEndDragging_WillDecelerate_WhenFetchingAndLoading() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		sut.isFetchingData = true
		sut.collectionView.refreshControl?.beginRefreshing()
		
		// When
		sut.scrollViewDidEndDragging(sut.collectionView, willDecelerate: true)
		
		// Then
		XCTAssertFalse(interactor.getSessionStatusCalled)
	}
	
	func testScrollView_DidEndDragging_WillDecelerate_WhenFetchingAndNotLoading() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		sut.isFetchingData = true
		sut.collectionView.refreshControl?.endRefreshing()
		
		// When
		sut.scrollViewDidEndDragging(sut.collectionView, willDecelerate: true)
		
		// Then
		XCTAssertFalse(interactor.getSessionStatusCalled)
	}
	
	func testScrollView_DidEndDragging_WillDecelerate_WhenNotFetchingAndLoading() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		sut.isFetchingData = false
		sut.collectionView.refreshControl?.beginRefreshing()
		
		// When
		sut.scrollViewDidEndDragging(sut.collectionView, willDecelerate: true)
		
		// Then
		XCTAssertTrue(interactor.getSessionStatusCalled)
	}
	
	func testScrollView_DidEndDragging_WillDecelerate_WhenNotFetchingAndNotLoading() {
		// Given
		loadView()
		
		let interactor = MainInteractorSpy()
		sut.interactor = interactor
		
		sut.isFetchingData = false
		sut.collectionView.refreshControl?.endRefreshing()
		
		// When
		sut.scrollViewDidEndDragging(sut.collectionView, willDecelerate: true)
		
		// Then
		XCTAssertFalse(interactor.getSessionStatusCalled)
	}
}

// MARK: - TEST PARALLAXABLE
extension MainViewControllerTests {
	func testScrollViewDidScroll_BounceFromTop() {
		// Given
		loadView()
		
		let parallaxableConstraint = NSLayoutConstraint()
		sut.parallaxableConstraint = parallaxableConstraint
		
		let contentOffset = CGPoint(x: 0, y: -100)
		sut.collectionView.setContentOffset(contentOffset, animated: false)
		
		// When
		sut.scrollViewDidScroll(sut.collectionView)
		
		// Then
		XCTAssertEqual(
			sut.parallaxableConstraint?.constant,
			contentOffset.y
		)
	}
	
	func testScrollViewDidScroll_NotBounce() {
		// Given
		loadView()
		
		let parallaxableConstraint = NSLayoutConstraint()
		sut.parallaxableConstraint = parallaxableConstraint
		
		let contentOffset = CGPoint(x: 0, y: 100)
		sut.collectionView.setContentOffset(contentOffset, animated: false)
		
		// When
		sut.scrollViewDidScroll(sut.collectionView)
		
		// Then
		XCTAssertEqual(
			sut.parallaxableConstraint?.constant,
			0
		)
	}
}
