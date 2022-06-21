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
	
	var agencies: [MediaLibraryCategoryProtocol] { get }
	func setAgencies(_ agencies: [MediaLibraryCategoryProtocol])
	
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
	
	var agencies: [MediaLibraryCategoryProtocol] = []
	func setAgencies(_ agencies: [MediaLibraryCategoryProtocol]) {
		self.agencies = agencies
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
