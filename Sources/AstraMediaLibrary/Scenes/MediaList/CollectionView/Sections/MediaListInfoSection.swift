//
//  MediaListInfoSection.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

struct MediaListInfoSection: KSPInfoSectionProtocol {
	var contents: [KSPInfoSectionContentProtocol]
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(44)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		return section
	}
}

struct MediaListInfoSectionContent: KSPInfoSectionContentProtocol {
	let title: String
	let description: String?
	let font: UIFont = .systemFont(ofSize: 15)
	let image: UIImage?
	let url: URL?
}
