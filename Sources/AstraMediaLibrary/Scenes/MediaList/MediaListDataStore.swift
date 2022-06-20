//
//  MediaListDataStore.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

// MARK: - DATASTORE PROTOCOL
protocol MediaListDataStoreProtocol {
	var category: MediaLibraryCategoryProtocol? { get }
	
	var items: [MediaLibraryItemProtocol] { get }
	func setItems(_ items: [MediaLibraryItemProtocol])
}

// MARK: - DATASTORE
class MediaListDataStore: MediaListDataStoreProtocol {
	var category: MediaLibraryCategoryProtocol?
	
	init(category: MediaLibraryCategoryProtocol?) {
		self.category = category
	}
	
	var items: [MediaLibraryItemProtocol] = []
	func setItems(_ items: [MediaLibraryItemProtocol]) {
		self.items = items
	}
}
