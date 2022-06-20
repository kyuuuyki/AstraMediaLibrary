//
//  MissionCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import AstraCoreModels
import Foundation
import UIKit

protocol MissionCollectionViewCellViewModelProtocol {
	var title: String { get }
	var description: String? { get }
	var imageUrl: URL? { get }
}

struct MissionCollectionViewCellViewModel: MissionCollectionViewCellViewModelProtocol {
	let title: String
	let description: String?
	let imageUrl: URL?
	
	init(mission: MediaLibraryCategoryProtocol) {
		self.title = mission.title
		self.description = mission.description
		self.imageUrl = mission.imageUrl
	}
}
