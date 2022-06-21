//  swiftlint:disable:this file_name
//
//  MediaLibraryCategoryMock.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

struct MediaLibraryCategoryAgencyMock: MediaLibraryCategoryProtocol, Equatable {
	var id: String = "id"
	var title: String = "title"
	var description: String?
	var categoryType: AstraCoreModels.MediaLibraryCategoryType? = .agency
	var imageUrl = URL(string: "www.google.com")!
	var link: URL?
	var key: String?
	var keyType: AstraCoreModels.MediaLibraryCategoryKeyType?
}

struct MediaLibraryCategoryMissionMock: MediaLibraryCategoryProtocol, Equatable {
	var id: String = "id"
	var title: String = "title"
	var description: String?
	var categoryType: AstraCoreModels.MediaLibraryCategoryType? = .mission
	var imageUrl = URL(string: "www.google.com")!
	var link: URL?
	var key: String?
	var keyType: AstraCoreModels.MediaLibraryCategoryKeyType?
}
