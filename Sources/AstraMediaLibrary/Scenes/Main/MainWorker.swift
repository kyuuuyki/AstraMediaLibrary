//
//  MainWorker.swift
//  AstraMediaLibrary
//

//  swiftlint:disable line_length

import AstraCoreModels
import Foundation

// MARK: - WORKER LOGIC
protocol MainWorkerProtocol {
	func getSessionStatus(completion: @escaping (AuthenticationSessionStatusType) -> Void)
	func getUserSecret(
		by userID: String,
		completion: @escaping (
			Result<UserSecretProtocol, Error>
		) -> Void
	)
	func getAstronomyPictureOfTheDay(
		completion: @escaping (Result<MediaLibraryAPODItemProtocol, Error>) -> Void
	)
	func getSuggestedCategoryList(
		completion: @escaping (Result<[MediaLibraryCategoryProtocol], Error>) -> Void
	)
	func getRecentMediaList(
		completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void
	)
}

// MARK: - WORKER
struct MainWorker: MainWorkerProtocol {
	let authenticationService: AuthenticationServiceProtocol
	let mediaLibraryService: MediaLibraryServiceProtocol
	let userService: UserServiceProtocol
	
	let supportedAPODMediaType: [MediaLibraryMediaType] = [.image]
	
	// MARK: GET - SESSION STATUS
	func getSessionStatus(completion: @escaping (AuthenticationSessionStatusType) -> Void) {
		authenticationService.getSessionStatus(completion: completion)
	}
	
	// MARK: GET - USER SECRET
	func getUserSecret(
		by userID: String,
		completion: @escaping (
			Result<UserSecretProtocol, Error>
		) -> Void
	) {
		userService.getUserSecret(by: userID, completion: completion)
	}
	
	// MARK: GET - ASTRONOMY PICTURE OF THE DAY
	func getAstronomyPictureOfTheDay(
		completion: @escaping (Result<MediaLibraryAPODItemProtocol, Error>) -> Void
	) {
		mediaLibraryService.getAPOD(date: Date()) { byDateResult in
			switch byDateResult {
			case .success(let apodItem):
				if let apodItem = apodItem, supportedAPODMediaType.contains(apodItem.mediaType) {
					completion(.success(apodItem))
					return
				}
			case .failure:
				break
			}
			
			// If APOD not available, get it randomly.
			getRandomAstronomyPictureOfTheDay(completion: completion)
		}
	}
	
	func getRandomAstronomyPictureOfTheDay(
		completion: @escaping (Result<MediaLibraryAPODItemProtocol, Error>) -> Void
	) {
		mediaLibraryService.getAPODList(count: 10) { byCountResult in
			switch byCountResult {
			case .success(let apodItems):
				if let apodItem = apodItems.first(where: { $0.mediaType == .image }) {
					completion(.success(apodItem))
					return
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	// MARK: GET - SUGGESTED CATEGORIES
	func getSuggestedCategoryList(
		completion: @escaping (Result<[MediaLibraryCategoryProtocol], Error>) -> Void
	) {
		mediaLibraryService.getSuggestedCategoryList { result in
			switch result {
			case .success(var categories):
				let search = MediaLibraryCategory(
					id: "search",
					title: "Search",
					description: nil,
					categoryType: nil,
					link: nil,
					imageUrl: URL(string: "https://www.androidfreeware.net/img2/com-pertl-johannes-jwst_status.jpg")!,
					key: nil,
					keyType: nil
				)
				categories.insert(search, at: 0)
				completion(.success(categories))
			case .failure:
				completion(.success([]))
			}
		}
	}
	
	// MARK: GET - RECENT MEDIA LIST
	func getRecentMediaList(
		completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void
	) {
		mediaLibraryService.getRecentMediaList(completion: completion)
	}
}

struct MediaLibraryCategory: MediaLibraryCategoryProtocol {
	let id: String
	let title: String
	let description: String?
	let categoryType: MediaLibraryCategoryType?
	let link: URL?
	let imageUrl: URL
	let key: String?
	let keyType: MediaLibraryCategoryKeyType?
}
