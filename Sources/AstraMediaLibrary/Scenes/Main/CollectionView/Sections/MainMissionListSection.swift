//
//  MainMissionListSection.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MainMissionListSection: KSPCollectionViewCompositionalLayoutSectionProtocol {
	let missions: [MediaLibraryCategoryProtocol]
	
	private let widthRatio: CGFloat = 3 / 4
	private let cardRatio: CGFloat = 10 / 3
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(
			MissionCollectionViewCell.self,
			bundle: .module
		)
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return missions.count
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let width = UIScreen.main.bounds.width * widthRatio
		let height = width / cardRatio
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(width),
			heightDimension: .absolute(height)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		
		return section
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			MissionCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		cell.viewModel = MissionCollectionViewCellViewModel(mission: missions[indexPath.item])
		return cell
	}
}
