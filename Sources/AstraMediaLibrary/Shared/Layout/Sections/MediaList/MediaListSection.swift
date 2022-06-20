//
//  MediaListSection.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MediaListSection: KSPCollectionViewCompositionalLayoutSectionProtocol {
	let items: [MediaLibraryItemProtocol]
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(MediaCollectionViewCell.self, bundle: .module)
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return items.count
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		item.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		
		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal * 2
		return section
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			MediaCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		cell.viewModel = MediaCollectionViewCellViewModel(item: items[indexPath.item])
		return cell
	}
}
