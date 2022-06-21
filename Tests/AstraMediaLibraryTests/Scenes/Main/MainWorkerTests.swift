//
//  MainWorkerTests.swift
//  AstraMediaLibrary
//

import AstraCoreModels
@testable import AstraMediaLibrary
import XCTest

// MARK: - WORKER
class MainWorkerTests: XCTestCase {
	// MARK: SUBJECT UNDER TEST
	private var sut: MainWorker!
	
	// MARK: TEST LIFECYCLE
	override func setUp() {
		super.setUp()
		setupMainWorker()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: TEST SETUP
	private func setupMainWorker() {
		let authenticationService = AuthenticationServiceMock()
		let mediaLibraryService = MediaLibraryServiceMock()
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
	}
}

// MARK: - TEST GET - SESSION STATUS
extension MainWorkerTests {
	func testGetSessionStatus_SignedIn() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		let status: AuthenticationSessionStatusType = .signedIn(
			apiKey: "apiKey",
			rateLimit: 0,
			rateLimitRemaining: 0
		)
		authenticationService.sessionStatusStub = status
		
		let mediaLibraryService = MediaLibraryServiceMock()
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutStatus: AuthenticationSessionStatusType!
		sut.getSessionStatus { status in
			sutStatus = status
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(authenticationService.sessionStatusCalled)
		XCTAssertEqual(sutStatus, status)
	}
	
	func testGetSessionStatus_SignedOut() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		let status: AuthenticationSessionStatusType = .signedOut
		authenticationService.sessionStatusStub = status
		
		let mediaLibraryService = MediaLibraryServiceMock()
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutStatus: AuthenticationSessionStatusType!
		sut.getSessionStatus { status in
			sutStatus = status
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(authenticationService.sessionStatusCalled)
		XCTAssertEqual(sutStatus, status)
	}
}

extension AuthenticationSessionStatusType: Equatable {
	public static func == (
		lhs: AuthenticationSessionStatusType,
		rhs: AuthenticationSessionStatusType
	) -> Bool {
		switch (lhs, rhs) {
		case (.signedIn, .signedIn):
			return true
		case (.signedOut, .signedOut):
			return true
		default:
			return false
		}
	}
}

// MARK: - TEST GET - ASTRONOMY PICTURE OF THE DAY
extension MainWorkerTests {
	func testGetAstronomyPictureOfTheDay_SuccessByDate() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let apodItem = MediaLibraryAPODItemMock()
		mediaLibraryService.astromonyPictureOfTheDayByDateStub = .success(apodItem)
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutApodItem: MediaLibraryAPODItemProtocol!
		sut.getAstronomyPictureOfTheDay { result in
			switch result {
			case .success(let apodItem):
				sutApodItem = apodItem
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.astromonyPictureOfTheDayByDateCalled)
		XCTAssertEqual(sutApodItem as? MediaLibraryAPODItemMock, apodItem)
	}
	
	func testGetAstronomyPictureOfTheDay_SuccessByCount() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let apodItem = MediaLibraryAPODItemMock()
		let error = MediaLibraryErrorMock()
		mediaLibraryService.astromonyPictureOfTheDayByDateStub = .failure(error)
		mediaLibraryService.astromonyPictureOfTheDayByCountStub = .success([apodItem])
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutApodItem: MediaLibraryAPODItemProtocol!
		sut.getAstronomyPictureOfTheDay { result in
			switch result {
			case .success(let apodItem):
				sutApodItem = apodItem
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.astromonyPictureOfTheDayByDateCalled)
		XCTAssertTrue(mediaLibraryService.astromonyPictureOfTheDayByCountCalled)
		XCTAssertEqual(sutApodItem as? MediaLibraryAPODItemMock, apodItem)
	}
	
	func testGetAstronomyPictureOfTheDay_Failure() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let error = MediaLibraryErrorMock()
		mediaLibraryService.astromonyPictureOfTheDayByDateStub = .failure(error)
		mediaLibraryService.astromonyPictureOfTheDayByCountStub = .failure(error)
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutApodItem: MediaLibraryAPODItemProtocol!
		sut.getAstronomyPictureOfTheDay { result in
			switch result {
			case .success(let apodItem):
				sutApodItem = apodItem
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.astromonyPictureOfTheDayByDateCalled)
		XCTAssertTrue(mediaLibraryService.astromonyPictureOfTheDayByCountCalled)
		XCTAssertNil(sutApodItem)
	}
}

// MARK: - TEST GET - SUGGESTED CATEGORIES
extension MainWorkerTests {
	func testGetSuggestedCategoryList_Success() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let agency = MediaLibraryCategoryAgencyMock()
		mediaLibraryService.suggestedCategoriesStub = .success([agency])
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutCategoriesCount = 0
		var sutAgency: MediaLibraryCategoryProtocol!
		sut.getSuggestedCategoryList { result in
			switch result {
			case .success(let categories):
				sutCategoriesCount = categories.count
				sutAgency = categories.first(where: { $0.categoryType == .agency })
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.suggestedCategoriesCalled)
		XCTAssertEqual(sutAgency as? MediaLibraryCategoryAgencyMock, agency)
		XCTAssertEqual(sutCategoriesCount, 2)
	}
	
	func testGetSuggestedCategoryList_Failure() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let error = MediaLibraryErrorMock()
		mediaLibraryService.suggestedCategoriesStub = .failure(error)
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutCategoriesCount = 0
		sut.getSuggestedCategoryList { result in
			switch result {
			case .success(let categories):
				sutCategoriesCount = categories.count
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.suggestedCategoriesCalled)
		XCTAssertEqual(sutCategoriesCount, 0)
	}
}

// MARK: - TEST GET - RECENT MEDIA LIST
extension MainWorkerTests {
	func testGetRecentMediaList_Success() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let item = MediaLibraryItemMock()
		mediaLibraryService.recentStub = .success([item])
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutItem: MediaLibraryItemProtocol!
		sut.getRecentMediaList { result in
			switch result {
			case .success(let items):
				sutItem = items.first
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.recentCalled)
		XCTAssertEqual(sutItem as? MediaLibraryItemMock, item)
	}
	
	func testGetRecentMediaList_Failure() {
		// Given
		let authenticationService = AuthenticationServiceMock()
		
		let mediaLibraryService = MediaLibraryServiceMock()
		let error = MediaLibraryErrorMock()
		mediaLibraryService.recentStub = .failure(error)
		
		sut = MainWorker(
			authenticationService: authenticationService,
			mediaLibraryService: mediaLibraryService
		)
		
		// When
		let expectation = XCTestExpectation()
		var sutItem: MediaLibraryItemProtocol!
		sut.getRecentMediaList { result in
			switch result {
			case .success(let items):
				sutItem = items.first
			case .failure:
				break
			}
			expectation.fulfill()
		}
		
		// Then
		wait(for: [expectation], timeout: AstraMediaLibraryTests.expectationTimeOut)
		
		XCTAssertTrue(mediaLibraryService.recentCalled)
		XCTAssertNil(sutItem)
	}
}
