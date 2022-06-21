//
//  MediaLibraryItemMock.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

struct MediaLibraryItemMock: MediaLibraryItemProtocol, Equatable {
	var id: String = "id"
	var title: String = "title"
	var description: String = "description"
	var imageUrl: URL?
	var link: URL?
	var center: String = "center"
	var keywords: [String] = []
	var createdAt: Date = .now
	var mediaType: AstraCoreModels.MediaLibraryMediaType = .image
}
