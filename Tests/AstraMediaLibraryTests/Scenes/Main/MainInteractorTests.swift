//
//  MainInteractorTests.swift
//  AstraMediaLibrary
//

//  swiftlint:disable identifier_name

import AstraCoreModels
@testable import AstraMediaLibrary
import XCTest

// MARK: - INTERACTOR
class MainInteractorTests: XCTestCase {
	// MARK: SUBJECT UNDER TEST
	private var sut: MainInteractor!
	
	// MARK: TEST LIFECYCLE
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: TEST DOUBLES
	private class MainPresenterSpy: MainPresenterProtocol {
		var presentSessionStatusExpectation = XCTestExpectation()
		var presentSessionStatusResponse: MainModel.SessionStatus.Response!
		func presentSessionStatus(response: MainModel.SessionStatus.Response) {
			presentSessionStatusResponse = response
			presentSessionStatusExpectation.fulfill()
		}
		
		var presentAstronomyPictureOfTheDayExpectation = XCTestExpectation()
		var presentAstronomyPictureOfTheDayResponse: MainModel.AstronomyPictureOfTheDay.Response!
		func presentAstronomyPictureOfTheDay(response: MainModel.AstronomyPictureOfTheDay.Response) {
			presentAstronomyPictureOfTheDayResponse = response
			presentAstronomyPictureOfTheDayExpectation.fulfill()
		}
		
		var presentSelectAPODExpectation = XCTestExpectation()
		var presentSelectAPODResponse: MainModel.SelectAPOD.Response!
		func presentSelectAPOD(response: MainModel.SelectAPOD.Response) {
			presentSelectAPODResponse = response
			presentSelectAPODExpectation.fulfill()
		}
		
		var presentSuggestedCategoryListExpectation = XCTestExpectation()
		var presentSuggestedCategoryListResponse: MainModel.SuggestedCategoryList.Response!
		func presentSuggestedCategoryList(response: MainModel.SuggestedCategoryList.Response) {
			presentSuggestedCategoryListResponse = response
			presentSuggestedCategoryListExpectation.fulfill()
		}
		
		var presentRecentMediaListExpectation = XCTestExpectation()
		var presentRecentMediaListResponse: MainModel.RecentMediaList.Response!
		func presentRecentMediaList(response: MainModel.RecentMediaList.Response) {
			presentRecentMediaListResponse = response
			presentRecentMediaListExpectation.fulfill()
		}
		
		var presentSelectCategoryExpectation = XCTestExpectation()
		var presentSelectCategoryResponse: MainModel.SelectCategory.Response!
		func presentSelectCategory(response: MainModel.SelectCategory.Response) {
			presentSelectCategoryResponse = response
			presentSelectCategoryExpectation.fulfill()
		}
		
		var presentSelectMediaExpectation = XCTestExpectation()
		var presentSelectMediaResponse: MainModel.SelectMedia.Response!
		func presentSelectMedia(response: MainModel.SelectMedia.Response) {
			presentSelectMediaResponse = response
			presentSelectMediaExpectation.fulfill()
		}
	}
	
	private class MainWorkerMock: MainWorkerProtocol {
		var getSessionStatusCalled = false
		var getSessionStatusStub: AuthenticationSessionStatusType!
		func getSessionStatus(completion: @escaping (AuthenticationSessionStatusType) -> Void) {
			getSessionStatusCalled = true
			completion(getSessionStatusStub)
		}
		
		var getAstronomyPictureOfTheDayCalled = false
		var getAstronomyPictureOfTheDayStub: Result<MediaLibraryAPODItemProtocol, Error>!
		func getAstronomyPictureOfTheDay(
			completion: @escaping (Result<MediaLibraryAPODItemProtocol, Error>) -> Void
		) {
			getAstronomyPictureOfTheDayCalled = true
			completion(getAstronomyPictureOfTheDayStub)
		}
		
		var getSuggestedCategoryListCalled = false
		var getSuggestedCategoryListStub: Result<[MediaLibraryCategoryProtocol], Error>!
		func getSuggestedCategoryList(
			completion: @escaping (Result<[MediaLibraryCategoryProtocol], Error>) -> Void
		) {
			getSuggestedCategoryListCalled = true
			completion(getSuggestedCategoryListStub)
		}
		
		var getRecentMediaListCalled = false
		var getRecentMediaListStub: Result<[MediaLibraryItemProtocol], Error>!
		func getRecentMediaList(
			completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void
		) {
			getRecentMediaListCalled = true
			completion(getRecentMediaListStub)
		}
	}
	
	private class MainDataStoreMock: MainDataStoreProtocol {
		var apodItem: MediaLibraryAPODItemProtocol?
		var setAPODItemCalled = false
		func setAPODItem(_ apodItem: MediaLibraryAPODItemProtocol?) {
			self.apodItem = apodItem
			setAPODItemCalled = true
		}
		
		var agencies: [MediaLibraryCategoryProtocol] = []
		var setAgenciesCalled = false
		func setAgencies(_ agencies: [MediaLibraryCategoryProtocol]) {
			self.agencies = agencies
			setAgenciesCalled = true
		}
		
		var missions: [MediaLibraryCategoryProtocol] = []
		var setMissionsCalled = false
		func setMissions(_ missions: [MediaLibraryCategoryProtocol]) {
			self.missions = missions
			setMissionsCalled = true
		}
		
		var recentItems: [MediaLibraryItemProtocol] = []
		var setRecentItemsCalled = false
		func setRecentItems(_ items: [MediaLibraryItemProtocol]) {
			self.recentItems = items
			setRecentItemsCalled = true
		}
	}
}

// MARK: - TEST SESSION STATUS
extension MainInteractorTests {
	func testGetSessionStatus_SignedIn() {
		// Given
		let worker = MainWorkerMock()
		worker.getSessionStatusStub = .signedIn(
			apiKey: "APIKEY",
			rateLimit: 0,
			rateLimitRemaining: 0
		)
		
		let presenter = MainPresenterSpy()
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: nil
		)
		
		let request = MainModel.SessionStatus.Request()
		
		// When
		sut.getSessionStatus(request: request)
		
		// Then
		wait(
			for: [presenter.presentSessionStatusExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSessionStatusCalled)
		XCTAssertTrue(presenter.presentSessionStatusResponse.isSignedIn)
	}
	
	func testGetSessionStatus_SignedOut() {
		// Given
		let worker = MainWorkerMock()
		worker.getSessionStatusStub = .signedOut
		
		let presenter = MainPresenterSpy()
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: nil
		)
		
		let request = MainModel.SessionStatus.Request()
		
		// When
		sut.getSessionStatus(request: request)
		
		// Then
		wait(
			for: [presenter.presentSessionStatusExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSessionStatusCalled)
		XCTAssertFalse(presenter.presentSessionStatusResponse.isSignedIn)
	}
}

// MARK: - TEST GET ASTRONOMY PICTURE OF THE DAY
extension MainInteractorTests {
	func testGetAstronomyPictureOfTheDay_Success() {
		// Given
		let worker = MainWorkerMock()
		let apodItem = MediaLibraryAPODItemMock()
		worker.getAstronomyPictureOfTheDayStub = .success(apodItem)
		
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.AstronomyPictureOfTheDay.Request()
		
		// When
		sut.getAstronomyPictureOfTheDay(request: request)
		
		// Then
		wait(
			for: [presenter.presentAstronomyPictureOfTheDayExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getAstronomyPictureOfTheDayCalled)
		XCTAssertTrue(dataStore.setAPODItemCalled)
		XCTAssertEqual(
			presenter.presentAstronomyPictureOfTheDayResponse.apodItem as? MediaLibraryAPODItemMock,
			apodItem
		)
	}
	
	func testGetAstronomyPictureOfTheDay_Failure() {
		// Given
		let worker = MainWorkerMock()
		let error = MediaLibraryErrorMock()
		worker.getAstronomyPictureOfTheDayStub = .failure(error)
		
		let dataStore = MainDataStoreMock()
		let presenter = MainPresenterSpy()
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.AstronomyPictureOfTheDay.Request()
		
		// When
		sut.getAstronomyPictureOfTheDay(request: request)
		
		// Then
		wait(
			for: [presenter.presentAstronomyPictureOfTheDayExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getAstronomyPictureOfTheDayCalled)
		XCTAssertTrue(dataStore.setAPODItemCalled)
		XCTAssertNil(presenter.presentAstronomyPictureOfTheDayResponse.apodItem)
	}
}

// MARK: - TEST SUGGESTED CATEGORY LIST
extension MainInteractorTests {
	func testGetSuggestedCategoryList_Success() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let agency = MediaLibraryCategoryAgencyMock()
		let mission = MediaLibraryCategoryMissionMock()
		worker.getSuggestedCategoryListStub = .success([agency, mission])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.SuggestedCategoryList.Request()
		
		// When
		sut.getSuggestedCategoryList(request: request)
		
		// Then
		wait(
			for: [presenter.presentSuggestedCategoryListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSuggestedCategoryListCalled)
		XCTAssertTrue(dataStore.setAgenciesCalled)
		XCTAssertTrue(dataStore.setMissionsCalled)
		XCTAssertEqual(
			presenter
				.presentSuggestedCategoryListResponse
				.agencies
				.first as? MediaLibraryCategoryAgencyMock,
			agency
		)
		XCTAssertEqual(
			presenter
				.presentSuggestedCategoryListResponse
				.missions
				.first as? MediaLibraryCategoryMissionMock,
			mission
		)
	}
	
	func testGetSuggestedCategoryList_SuccessWithAgency() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let agency = MediaLibraryCategoryAgencyMock()
		worker.getSuggestedCategoryListStub = .success([agency])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.SuggestedCategoryList.Request()
		
		// When
		sut.getSuggestedCategoryList(request: request)
		
		// Then
		wait(
			for: [presenter.presentSuggestedCategoryListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSuggestedCategoryListCalled)
		XCTAssertTrue(dataStore.setAgenciesCalled)
		XCTAssertTrue(dataStore.setMissionsCalled)
		XCTAssertEqual(
			presenter
				.presentSuggestedCategoryListResponse
				.agencies
				.first as? MediaLibraryCategoryAgencyMock,
			agency
		)
		XCTAssertTrue(presenter.presentSuggestedCategoryListResponse.missions.isEmpty
		)
	}
	
	func testGetSuggestedCategoryList_SuccessWithMission() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let mission = MediaLibraryCategoryMissionMock()
		worker.getSuggestedCategoryListStub = .success([mission])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.SuggestedCategoryList.Request()
		
		// When
		sut.getSuggestedCategoryList(request: request)
		
		// Then
		wait(
			for: [presenter.presentSuggestedCategoryListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSuggestedCategoryListCalled)
		XCTAssertTrue(dataStore.setAgenciesCalled)
		XCTAssertTrue(dataStore.setMissionsCalled)
		XCTAssertTrue(presenter.presentSuggestedCategoryListResponse.agencies.isEmpty)
		XCTAssertEqual(
			presenter
				.presentSuggestedCategoryListResponse
				.missions
				.first as? MediaLibraryCategoryMissionMock,
			mission
		)
	}
	
	func testGetSuggestedCategoryList_SuccessWithEmptyList() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let categories = [MediaLibraryCategoryProtocol]()
		worker.getSuggestedCategoryListStub = .success(categories)
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.SuggestedCategoryList.Request()
		
		// When
		sut.getSuggestedCategoryList(request: request)
		
		// Then
		wait(
			for: [presenter.presentSuggestedCategoryListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSuggestedCategoryListCalled)
		XCTAssertTrue(dataStore.setAgenciesCalled)
		XCTAssertTrue(dataStore.setMissionsCalled)
		XCTAssertTrue(presenter.presentSuggestedCategoryListResponse.agencies.isEmpty)
		XCTAssertTrue(presenter.presentSuggestedCategoryListResponse.missions.isEmpty)
	}
	
	func testGetSuggestedCategoryList_Failure() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let error = MediaLibraryErrorMock()
		worker.getSuggestedCategoryListStub = .failure(error)
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.SuggestedCategoryList.Request()
		
		// When
		sut.getSuggestedCategoryList(request: request)
		
		// Then
		wait(
			for: [presenter.presentSuggestedCategoryListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getSuggestedCategoryListCalled)
		XCTAssertTrue(dataStore.setAgenciesCalled)
		XCTAssertTrue(dataStore.setMissionsCalled)
		XCTAssertTrue(presenter.presentSuggestedCategoryListResponse.agencies.isEmpty)
		XCTAssertTrue(presenter.presentSuggestedCategoryListResponse.missions.isEmpty)
	}
}

// MARK: - TEST RECENT MEDIA LIST
extension MainInteractorTests {
	func testGetRecentMediaList_Success() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let item = MediaLibraryItemMock()
		worker.getRecentMediaListStub = .success([item])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.RecentMediaList.Request()
		
		// When
		sut.getRecentMediaList(request: request)
		
		// Then
		wait(
			for: [presenter.presentRecentMediaListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getRecentMediaListCalled)
		XCTAssertTrue(dataStore.setRecentItemsCalled)
		XCTAssertEqual(
			presenter.presentRecentMediaListResponse.items.first as? MediaLibraryItemMock,
			item
		)
	}
	
	func testGetRecentMediaList_Failure() {
		// Given
		let presenter = MainPresenterSpy()
		let dataStore = MainDataStoreMock()
		
		let worker = MainWorkerMock()
		let error = MediaLibraryErrorMock()
		worker.getRecentMediaListStub = .failure(error)
		
		sut = MainInteractor(
			presenter: presenter,
			worker: worker,
			dataStore: dataStore
		)
		
		let request = MainModel.RecentMediaList.Request()
		
		// When
		sut.getRecentMediaList(request: request)
		
		// Then
		wait(
			for: [presenter.presentRecentMediaListExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertTrue(worker.getRecentMediaListCalled)
		XCTAssertTrue(dataStore.setRecentItemsCalled)
		XCTAssertTrue(presenter.presentRecentMediaListResponse.items.isEmpty)
	}
}

// MARK: - TEST SELECT APOD
extension MainInteractorTests {
	func testSelectAPOD_Exists() {
		// Given
		let presenter = MainPresenterSpy()
		
		let dataStore = MainDataStoreMock()
		let apodItem = MediaLibraryAPODItemMock()
		let item = APODItem(apodItem: apodItem)
		dataStore.setAPODItem(apodItem)
		
		sut = MainInteractor(
			presenter: presenter,
			worker: nil,
			dataStore: dataStore
		)
		
		let request = MainModel.SelectAPOD.Request()
		
		// When
		sut.selectAPOD(request: request)
		
		// Then
		wait(
			for: [presenter.presentSelectAPODExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertEqual(
			presenter.presentSelectAPODResponse.item as? APODItem,
			item
		)
	}
	
	func testSelectAPOD_NotExists() {
		// Given
		let presenter = MainPresenterSpy()
		
		let dataStore = MainDataStoreMock()
		let apodItem = PlaceholderAPODItem()
		let item = APODItem(apodItem: apodItem)
		dataStore.setAPODItem(apodItem)
		
		sut = MainInteractor(
			presenter: presenter,
			worker: nil,
			dataStore: dataStore
		)
		
		let request = MainModel.SelectAPOD.Request()
		
		// When
		sut.selectAPOD(request: request)
		
		// Then
		wait(
			for: [presenter.presentSelectAPODExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertEqual(
			presenter.presentSelectAPODResponse.item as? APODItem,
			item
		)
	}
}

// MARK: - TEST SELECT CATEGORY
extension MainInteractorTests {
	func testSelectCategory_Agency() {
		// Given
		let presenter = MainPresenterSpy()
		
		let dataStore = MainDataStoreMock()
		let agency = MediaLibraryCategoryAgencyMock()
		dataStore.setAgencies([agency])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: nil,
			dataStore: dataStore
		)
		
		let request = MainModel.SelectCategory.Request(index: 0, isMission: false)
		
		// When
		sut.selectCategory(request: request)
		
		// Then
		wait(
			for: [presenter.presentSelectCategoryExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertEqual(
			presenter.presentSelectCategoryResponse.category as? MediaLibraryCategoryAgencyMock,
			agency
		)
	}
	
	func testSelectCategory_Mission() {
		// Given
		let presenter = MainPresenterSpy()
		
		let dataStore = MainDataStoreMock()
		let mission = MediaLibraryCategoryMissionMock()
		dataStore.setMissions([mission])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: nil,
			dataStore: dataStore
		)
		
		let request = MainModel.SelectCategory.Request(index: 0, isMission: true)
		
		// When
		sut.selectCategory(request: request)
		
		// Then
		wait(
			for: [presenter.presentSelectCategoryExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertEqual(
			presenter.presentSelectCategoryResponse.category as? MediaLibraryCategoryMissionMock,
			mission
		)
	}
}

// MARK: - TEST SELECT MEDIA
extension MainInteractorTests {
	func testSelectMedia() {
		// Given
		let presenter = MainPresenterSpy()
		
		let dataStore = MainDataStoreMock()
		let item = MediaLibraryItemMock()
		dataStore.setRecentItems([item])
		
		sut = MainInteractor(
			presenter: presenter,
			worker: nil,
			dataStore: dataStore
		)
		
		let request = MainModel.SelectMedia.Request(index: 0)
		
		// When
		sut.selectMedia(request: request)
		
		// Then
		wait(
			for: [presenter.presentSelectMediaExpectation],
			timeout: AstraMediaLibraryTests.expectationTimeOut
		)
		
		XCTAssertEqual(
			presenter.presentSelectMediaResponse.item as? MediaLibraryItemMock,
			item
		)
	}
}
