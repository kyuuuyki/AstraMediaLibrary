//
//  WidgetCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import AstraCoreModels
import Foundation
import UIKit

protocol WidgetCollectionViewCellViewModelProtocol {
	var title: String { get }
	var imageUrl: URL? { get }
}

struct WidgetCollectionViewCellViewModel: WidgetCollectionViewCellViewModelProtocol {
	let title: String
	let imageUrl: URL?
	
	init(category: MediaLibraryCategoryProtocol) {
		self.title = category.title
		self.imageUrl = category.imageUrl
	}
}
