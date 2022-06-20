//
//  MainDataStore.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

// MARK: - DATASTORE PROTOCOL
protocol MainDataStoreProtocol {
	var apodItem: MediaLibraryAPODItemProtocol? { get }
	func setAPODItem(_ apodItem: MediaLibraryAPODItemProtocol?)
	
	var categories: [MediaLibraryCategoryProtocol] { get }
	func setCategories(_ categories: [MediaLibraryCategoryProtocol])
	
	var missions: [MediaLibraryCategoryProtocol] { get }
	func setMissions(_ missions: [MediaLibraryCategoryProtocol])
	
	var recentItems: [MediaLibraryItemProtocol] { get }
	func setRecentItems(_ items: [MediaLibraryItemProtocol])
}

// MARK: - DATASTORE
class MainDataStore: MainDataStoreProtocol {
	var apodItem: MediaLibraryAPODItemProtocol?
	func setAPODItem(_ apodItem: MediaLibraryAPODItemProtocol?) {
		self.apodItem = apodItem
	}
	
	var categories: [MediaLibraryCategoryProtocol] = []
	func setCategories(_ categories: [MediaLibraryCategoryProtocol]) {
		self.categories = categories
	}
	
	var missions: [MediaLibraryCategoryProtocol] = []
	func setMissions(_ missions: [MediaLibraryCategoryProtocol]) {
		self.missions = missions
	}
	
	var recentItems: [MediaLibraryItemProtocol] = []
	func setRecentItems(_ items: [MediaLibraryItemProtocol]) {
		self.recentItems = items
	}
}
