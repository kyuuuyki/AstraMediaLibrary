//
//  MediaLibraryServiceMock.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

class MediaLibraryServiceMock: MediaLibraryServiceProtocol {
	var astromonyPictureOfTheDayByDateCalled = false
	var astromonyPictureOfTheDayByDateStub: Result<MediaLibraryAPODItemProtocol?, Error>!
	func astromonyPictureOfTheDay(
		date: Date,
		completion: @escaping (Result<MediaLibraryAPODItemProtocol?, Error>) -> Void
	) {
		astromonyPictureOfTheDayByDateCalled = true
		completion(astromonyPictureOfTheDayByDateStub)
	}
	
	var astromonyPictureOfTheDayByCountCalled = false
	var astromonyPictureOfTheDayByCountStub: Result<[MediaLibraryAPODItemProtocol], Error>!
	func astromonyPictureOfTheDay(
		count: Int,
		completion: @escaping (Result<[MediaLibraryAPODItemProtocol], Error>) -> Void
	) {
		astromonyPictureOfTheDayByCountCalled = true
		completion(astromonyPictureOfTheDayByCountStub)
	}
	
	var suggestedCategoriesCalled = false
	var suggestedCategoriesStub: Result<[MediaLibraryCategoryProtocol], Error>!
	func suggestedCategories(
		completion: @escaping (Result<[MediaLibraryCategoryProtocol], Error>) -> Void
	) {
		suggestedCategoriesCalled = true
		completion(suggestedCategoriesStub)
	}
	
	var recentCalled = false
	var recentStub: Result<[MediaLibraryItemProtocol], Error>!
	func recent(completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void) {
		recentCalled = true
		completion(recentStub)
	}
	
	var popularCalled = false
	var popularStub: Result<[MediaLibraryItemProtocol], Error>!
	func popular(completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void) {
		popularCalled = true
		completion(popularStub)
	}
	
	var searchCalled = false
	var searchStub: Result<[MediaLibraryItemProtocol], Error>!
	func search(
		keyword: String,
		page: Int?,
		completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void
	) {
		searchCalled = true
		completion(searchStub)
	}
	
	var assetCalled = false
	var assetStub: Result<[MediaLibraryAssetItemProtocol], Error>!
	func asset(
		id: String,
		completion: @escaping (Result<[MediaLibraryAssetItemProtocol], Error>) -> Void
	) {
		assetCalled = true
		completion(assetStub)
	}
}
