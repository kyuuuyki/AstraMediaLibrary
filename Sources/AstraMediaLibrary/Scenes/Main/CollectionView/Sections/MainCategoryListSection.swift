//
//  MainCategoryListSection.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MainCategoryListSection: KSPCollectionViewCompositionalLayoutSectionProtocol {
	let categories: [MediaLibraryCategoryProtocol]
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(WidgetCollectionViewCell.self, bundle: .module)
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return categories.count
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		// Item
		let itemWidth: CGFloat = UIScreen.main.bounds.width / 4.5
		let itemHeight: CGFloat = itemWidth / 3 * 4
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(itemWidth),
			heightDimension: .absolute(itemHeight)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let itemInset = DesignSystem.Spacing.interitem / 2
		item.contentInsets = NSDirectionalEdgeInsets(
			top: itemInset,
			leading: itemInset,
			bottom: itemInset,
			trailing: itemInset
		)
		
		// Group
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .estimated(500),
			heightDimension: .absolute(itemHeight * 2)
		)
		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		// Section
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal * 2
		
		return section
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			WidgetCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		cell.viewModel = WidgetCollectionViewCellViewModel(category: categories[indexPath.item])
		return cell
	}
}
