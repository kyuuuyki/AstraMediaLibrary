//
//  APODCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import AstraCoreModels
import Foundation
import UIKit

protocol APODCollectionViewCellViewModelProtocol {
	var imageUrl: URL? { get }
	var shouldDisplayRandomBadge: Bool { get }
}

struct APODCollectionViewCellViewModel: APODCollectionViewCellViewModelProtocol {
	let imageUrl: URL?
	let shouldDisplayRandomBadge: Bool
	
	init(item: MediaLibraryAPODItemProtocol) {
		self.imageUrl = item.imageUrl
		
		if let timeZone = TimeZone(identifier: "UTC") {
			var calendar = Calendar(identifier: .gregorian)
			calendar.timeZone = timeZone
			self.shouldDisplayRandomBadge = !calendar.isDateInToday(item.date)
		} else {
			self.shouldDisplayRandomBadge = true
		}
	}
}
