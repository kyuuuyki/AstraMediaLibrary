//  swiftlint:disable:this file_name
//
//  MediaDetailTextSection.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

struct MediaDetailTitleSection: KSPTextSectionProtocol {
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
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		return section
	}
}

struct MediaDetailDateSection: KSPTextSectionProtocol {
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
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal / 4
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		return section
	}
}

struct MediaDetailDescriptionSection: KSPTextSectionProtocol {
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
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		section.contentInsets.bottom = DesignSystem.Spacing.Edge.normal
		return section
	}
}
