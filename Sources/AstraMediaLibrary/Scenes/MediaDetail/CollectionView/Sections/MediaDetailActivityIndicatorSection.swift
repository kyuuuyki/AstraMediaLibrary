//
//  MediaDetailActivityIndicatorSection.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

struct MediaDetailActivityIndicatorSection: KSPActivityIndicatorSectionProtocol {
	let shouldAnimated: Bool
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
}
