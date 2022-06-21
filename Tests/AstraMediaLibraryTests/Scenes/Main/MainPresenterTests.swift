//
//  MainPresenterTests.swift
//  AstraMediaLibrary
//

@testable import AstraMediaLibrary
import XCTest

// MARK: - PRESENTER
class MainPresenterTests: XCTestCase {
	// MARK: SUBJECT UNDER TEST
	private var sut: MainPresenter!
	
	// MARK: TEST LIFECYCLE
	override func setUp() {
		super.setUp()
		setupMainPresenter()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: TEST SETUP
	private func setupMainPresenter() {
		sut = MainPresenter()
	}
	
	// MARK: TEST DOUBLES
	private class MainViewControllerSpy: MainViewControllerProtocol {
		var displaySessionStatusCalled = false
		var displaySessionStatusViewModel: MainModel.SessionStatus.ViewModel!
		func displaySessionStatus(viewModel: MainModel.SessionStatus.ViewModel) {
			displaySessionStatusCalled = true
			displaySessionStatusViewModel = viewModel
		}
		
		var displayAstronomyPictureOfTheDayCalled = false
		var displayAstronomyPictureOfTheDayViewModel: MainModel.AstronomyPictureOfTheDay.ViewModel!
		func displayAstronomyPictureOfTheDay(viewModel: MainModel.AstronomyPictureOfTheDay.ViewModel) {
			displayAstronomyPictureOfTheDayCalled = true
			displayAstronomyPictureOfTheDayViewModel = viewModel
		}
		
		var displaySelectAPODCalled = false
		var displaySelectAPODViewModel: MainModel.SelectAPOD.ViewModel!
		func displaySelectAPOD(viewModel: MainModel.SelectAPOD.ViewModel) {
			displaySelectAPODCalled = true
			displaySelectAPODViewModel = viewModel
		}
		
		var displaySuggestedCategoryListCalled = false
		var displaySuggestedCategoryListViewModel: MainModel.SuggestedCategoryList.ViewModel!
		func displaySuggestedCategoryList(viewModel: MainModel.SuggestedCategoryList.ViewModel) {
			displaySuggestedCategoryListCalled = true
			displaySuggestedCategoryListViewModel = viewModel
		}
		
		var displayRecentMediaListCalled = false
		var displayRecentMediaListViewModel: MainModel.RecentMediaList.ViewModel!
		func displayRecentMediaList(viewModel: MainModel.RecentMediaList.ViewModel) {
			displayRecentMediaListCalled = true
			displayRecentMediaListViewModel = viewModel
		}
		
		var displaySelectCategoryCalled = false
		var displaySelectCategoryViewModel: MainModel.SelectCategory.ViewModel!
		func displaySelectCategory(viewModel: MainModel.SelectCategory.ViewModel) {
			displaySelectCategoryCalled = true
			displaySelectCategoryViewModel = viewModel
		}
		
		var displaySelectMediaCalled = false
		var displaySelectMediaViewModel: MainModel.SelectMedia.ViewModel!
		func displaySelectMedia(viewModel: MainModel.SelectMedia.ViewModel) {
			displaySelectMediaCalled = true
			displaySelectMediaViewModel = viewModel
		}
	}
}

// MARK: - PRESENT SESSION STATUS
extension MainPresenterTests {
	func testPresentSessionStatus_SignedIn() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let response = MainModel.SessionStatus.Response(isSignedIn: true)
		
		// When
		sut.presentSessionStatus(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySessionStatusCalled)
		XCTAssertFalse(viewController.displaySessionStatusViewModel.shouldDisplaySignIn)
	}
	
	func testPresentSessionStatus_SignedOut() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let response = MainModel.SessionStatus.Response(isSignedIn: false)
		
		// When
		sut.presentSessionStatus(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySessionStatusCalled)
		XCTAssertTrue(viewController.displaySessionStatusViewModel.shouldDisplaySignIn)
	}
}

// MARK: - TEST ASTRONOMY PICTURE OF THE DAY
extension MainPresenterTests {
	func testPresentAstronomyPictureOfTheDay() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let apodItem = MediaLibraryAPODItemMock()
		let response = MainModel.AstronomyPictureOfTheDay.Response(apodItem: apodItem)
		
		// When
		sut.presentAstronomyPictureOfTheDay(response: response)
		
		// Then
		XCTAssertTrue(viewController.displayAstronomyPictureOfTheDayCalled)
		XCTAssertEqual(
			viewController.displayAstronomyPictureOfTheDayViewModel.apodItem as? MediaLibraryAPODItemMock,
			apodItem
		)
	}
}

// MARK: - TEST SUGGESTED CATEGORY LIST
extension MainPresenterTests {
	func testPresentSuggestedCategoryList() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let agency = MediaLibraryCategoryAgencyMock()
		let mission = MediaLibraryCategoryMissionMock()
		let response = MainModel.SuggestedCategoryList.Response(
			agencies: [agency],
			missions: [mission]
		)
		
		// When
		sut.presentSuggestedCategoryList(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySuggestedCategoryListCalled)
		XCTAssertEqual(
			viewController
				.displaySuggestedCategoryListViewModel
				.agencies
				.first as? MediaLibraryCategoryAgencyMock,
			agency
		)
		XCTAssertEqual(
			viewController
				.displaySuggestedCategoryListViewModel
				.missions
				.first as? MediaLibraryCategoryMissionMock,
			mission
		)
	}
}

// MARK: - TEST RECENT MEDIA LIST
extension MainPresenterTests {
	func testPresentRecentMediaList() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let item = MediaLibraryItemMock()
		let response = MainModel.RecentMediaList.Response(items: [item])
		
		// When
		sut.presentRecentMediaList(response: response)
		
		// Then
		XCTAssertTrue(viewController.displayRecentMediaListCalled)
		XCTAssertEqual(
			viewController.displayRecentMediaListViewModel.items.first as? MediaLibraryItemMock,
			item
		)
	}
}

// MARK: - TEST SELECT APOD
extension MainPresenterTests {
	func testPresentSelectAPOD() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let apodItem = MediaLibraryAPODItemMock()
		let item = APODItem(apodItem: apodItem)
		let response = MainModel.SelectAPOD.Response(item: item)
		
		// When
		sut.presentSelectAPOD(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySelectAPODCalled)
		XCTAssertEqual(
			viewController.displaySelectAPODViewModel.item as? APODItem,
			item
		)
	}
}

// MARK: - TEST SELECT CATEGORY
extension MainPresenterTests {
	func testPresentSelectCategory_Agency() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let category = MediaLibraryCategoryAgencyMock()
		let response = MainModel.SelectCategory.Response(category: category)
		
		// When
		sut.presentSelectCategory(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySelectCategoryCalled)
		XCTAssertEqual(
			viewController
				.displaySelectCategoryViewModel
				.category as? MediaLibraryCategoryAgencyMock,
			category
		)
	}
	
	func testPresentSelectCategory_Mission() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let category = MediaLibraryCategoryMissionMock()
		let response = MainModel.SelectCategory.Response(category: category)
		
		// When
		sut.presentSelectCategory(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySelectCategoryCalled)
		XCTAssertEqual(
			viewController
				.displaySelectCategoryViewModel
				.category as? MediaLibraryCategoryMissionMock,
			category
		)
	}
}

// MARK: - TEST SELECT MEDIA
extension MainPresenterTests {
	func testPresentSelectMedia() {
		// Given
		let viewController = MainViewControllerSpy()
		sut.viewController = viewController
		
		let item = MediaLibraryItemMock()
		let response = MainModel.SelectMedia.Response(item: item)
		
		// When
		sut.presentSelectMedia(response: response)
		
		// Then
		XCTAssertTrue(viewController.displaySelectMediaCalled)
		XCTAssertEqual(
			viewController.displaySelectMediaViewModel.item as? MediaLibraryItemMock,
			item
		)
	}
}
