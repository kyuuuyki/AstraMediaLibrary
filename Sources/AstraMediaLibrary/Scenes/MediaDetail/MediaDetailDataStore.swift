//
//  MediaDetailDataStore.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import UIKit

// MARK: - DATASTORE PROTOCOL
protocol MediaDetailDataStoreProtocol {
	var item: MediaLibraryItemProtocol { get }
	
	var assetItem: MediaLibraryAssetItemProtocol? { get }
	func setAssetItem(_ assetItem: MediaLibraryAssetItemProtocol?)
	
	var itemImage: UIImage? { get }
	func setItemImage(_ itemImage: UIImage?)
}

// MARK: - DATASTORE
class MediaDetailDataStore: MediaDetailDataStoreProtocol {
	var item: MediaLibraryItemProtocol
	
	init(item: MediaLibraryItemProtocol) {
		self.item = item
	}
	
	var assetItem: MediaLibraryAssetItemProtocol?
	func setAssetItem(_ assetItem: MediaLibraryAssetItemProtocol?) {
		self.assetItem = assetItem
	}
	
	var itemImage: UIImage?
	func setItemImage(_ itemImage: UIImage?) {
		self.itemImage = itemImage
	}
}
