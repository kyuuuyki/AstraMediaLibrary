//
//  MainModel.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

enum MainModel {
	// MARK: - ASTRONOMY PICTURE OF THE DAY
	enum SessionStatus {
		struct Request {
		}
		
		struct Response {
			let isSignedIn: Bool
		}
		
		struct ViewModel {
			let shouldDisplaySignIn: Bool
		}
	}
	
	// MARK: - SELECT APOD
	enum SelectAPOD {
		struct Request {
		}
		
		struct Response {
			let item: MediaLibraryItemProtocol
		}
		
		struct ViewModel {
			let item: MediaLibraryItemProtocol
		}
	}
	
	// MARK: - ASTRONOMY PICTURE OF THE DAY
	enum AstronomyPictureOfTheDay {
		struct Request {
		}
		
		struct Response {
			let apodItem: MediaLibraryAPODItemProtocol?
		}
		
		struct ViewModel {
			let apodItem: MediaLibraryAPODItemProtocol?
		}
	}
	
	// MARK: - SUGGESTED CATEGORY LIST
	enum SuggestedCategoryList {
		struct Request {
		}
		
		struct Response {
			let categories: [MediaLibraryCategoryProtocol]
			let missions: [MediaLibraryCategoryProtocol]
		}
		
		struct ViewModel {
			let categories: [MediaLibraryCategoryProtocol]
			let missions: [MediaLibraryCategoryProtocol]
		}
	}
	
	// MARK: - RECENT MEDIA LIST
	enum RecentMediaList {
		struct Request {
		}
		
		struct Response {
			let items: [MediaLibraryItemProtocol]
		}
		
		struct ViewModel {
			let items: [MediaLibraryItemProtocol]
		}
	}
	
	// MARK: - SELECT CATEGORY
	enum SelectCategory {
		struct Request {
			let index: Int
			let isMission: Bool
		}
		
		struct Response {
			let category: MediaLibraryCategoryProtocol
		}
		
		struct ViewModel {
			let category: MediaLibraryCategoryProtocol
		}
	}
	
	// MARK: - SELECT MEDIA
	enum SelectMedia {
		struct Request {
			let index: Int
		}
		
		struct Response {
			let item: MediaLibraryItemProtocol
		}
		
		struct ViewModel {
			let item: MediaLibraryItemProtocol
		}
	}
}
