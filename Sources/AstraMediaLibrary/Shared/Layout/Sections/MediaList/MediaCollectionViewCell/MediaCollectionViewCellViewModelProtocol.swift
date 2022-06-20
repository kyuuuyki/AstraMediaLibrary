//
//  MediaCollectionViewCellViewModelProtocol.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

protocol MediaCollectionViewCellViewModelProtocol {
	var imageUrl: URL? { get }
	var title: String { get }
	var subtitle: String { get }
	var shouldDisplayVideoIndicator: Bool { get }
}

struct MediaCollectionViewCellViewModel: MediaCollectionViewCellViewModelProtocol {
	let imageUrl: URL?
	let title: String
	let subtitle: String
	let shouldDisplayVideoIndicator: Bool
	
	init(item: MediaLibraryItemProtocol) {
		self.imageUrl = item.imageUrl
		self.title = item.title
		let dateString = String(date: item.createdAt, format: "EEEE, MMM d, yyyy")
		self.subtitle = item.center + " · " + dateString
		self.shouldDisplayVideoIndicator = item.mediaType == .video
	}
}
