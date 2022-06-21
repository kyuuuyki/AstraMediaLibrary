//
//  MainCompositionalLayoutTests.swift
//  AstraMediaLibrary
//

import AstraCoreModels
@testable import AstraMediaLibrary
import XCTest

// MARK: - INTERACTOR
class MainCompositionalLayoutTests: XCTestCase {
	// MARK: SUBJECT UNDER TEST
	private var sut: MainCompositionalLayout!
	
	// MARK: TEST LIFECYCLE
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
}

// MARK: - TEST MAIN APOD SECTION
extension MainCompositionalLayoutTests {
	func testMainAPODSection_APODViewModelNotExists() {
		// Given
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: nil,
			suggestedCategoryListViewModel: nil,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainActivityIndicatorSection })
		XCTAssertTrue(isSectionExists)
		XCTAssertEqual(sut.sections.count, 1)
	}
	
	func testMainAPODSection_APODExists() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: nil,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainAPODSection })
		XCTAssertTrue(isSectionExists)
	}
	
	func testMainAPODSection_APODNotExists() {
		// Given
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: nil
		)
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: nil,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainAPODSection })
		XCTAssertTrue(isSectionExists)
	}
}

// MARK: - TEST MAIN CATEGORYLIST SECTION
extension MainCompositionalLayoutTests {
	func testMainCategoryListSection_CategoryListNotEmpty() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		let agency = MediaLibraryCategoryAgencyMock()
		let suggestedCategoryListViewModel = MainModel.SuggestedCategoryList.ViewModel(
			agencies: [agency],
			missions: []
		)
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: suggestedCategoryListViewModel,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainCategoryListSection })
		XCTAssertTrue(isSectionExists)
	}
	
	func testMainCategoryListSection_CategoryListEmpty() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		let suggestedCategoryListViewModel = MainModel.SuggestedCategoryList.ViewModel(
			agencies: [],
			missions: []
		)
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: suggestedCategoryListViewModel,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainCategoryListSection })
		XCTAssertFalse(isSectionExists)
	}
}

// MARK: - TEST MAIN MISSIONLIST SECTION
extension MainCompositionalLayoutTests {
	func testMainMissionListSection_MissionListNotEmpty() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		let mission = MediaLibraryCategoryMissionMock()
		let suggestedCategoryListViewModel = MainModel.SuggestedCategoryList.ViewModel(
			agencies: [],
			missions: [mission]
		)
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: suggestedCategoryListViewModel,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainMissionListSection })
		XCTAssertTrue(isSectionExists)
	}
	
	func testMainMissionListSection_MissionListEmpty() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		let suggestedCategoryListViewModel = MainModel.SuggestedCategoryList.ViewModel(
			agencies: [],
			missions: []
		)
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: suggestedCategoryListViewModel,
			recentMediaListViewModel: nil
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MainMissionListSection })
		XCTAssertFalse(isSectionExists)
	}
}

// MARK: - TEST MEDIALIST SECTION
extension MainCompositionalLayoutTests {
	func testMediaListSection_MediaListNotEmpty() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		let item = MediaLibraryItemMock()
		let recentMediaListViewModel = MainModel.RecentMediaList.ViewModel(items: [item])
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: nil,
			recentMediaListViewModel: recentMediaListViewModel
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MediaListSection })
		XCTAssertTrue(isSectionExists)
	}
	
	func testMediaListSection_MediaListEmpty() {
		// Given
		let apodItem = MediaLibraryAPODItemMock()
		let astronomyPictureOfTheDayViewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(
			apodItem: apodItem
		)
		
		let recentMediaListViewModel = MainModel.RecentMediaList.ViewModel(items: [])
		
		// When
		sut = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: nil,
			recentMediaListViewModel: recentMediaListViewModel
		)
		
		// Then
		let isSectionExists = sut.sections.contains(where: { $0 is MediaListSection })
		XCTAssertFalse(isSectionExists)
	}
}
