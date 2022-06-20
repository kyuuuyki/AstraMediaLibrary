//  swiftlint:disable:this file_name
//
//  MediaListTextSection.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

struct MediaListDescriptionSection: KSPTextSectionProtocol {
	let text: String?
	let textColor: UIColor
	let font: UIFont
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(44)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal / 2
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		return section
	}
}
