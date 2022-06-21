//
//  MediaLibraryAPODItemMock.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

struct MediaLibraryAPODItemMock: MediaLibraryAPODItemProtocol, Equatable {
	var date: Date = .now
	var title: String = "title"
	var description: String?
	var imageUrl = URL(string: "www.google.com")!
	var imageHDUrl: URL?
	var link: URL?
	var mediaType: MediaLibraryMediaType = .image
}
