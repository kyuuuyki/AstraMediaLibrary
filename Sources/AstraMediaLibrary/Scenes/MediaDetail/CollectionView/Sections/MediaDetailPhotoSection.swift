//
//  MediaDetailPhotoSection.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

struct MediaDetailPhotoSection: KSPCollectionViewCompositionalLayoutSectionProtocol {
	let imageUrl: URL
	let imageSize: CGSize
	
	private let imageRatio: CGFloat = DesignSystem.Ratio.image
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(
			ImageCollectionViewCell.self,
			bundle: .module
		)
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return 1
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let width = UIScreen.main.bounds.width
		let height = imageSize.height * width / imageSize.width
		let minimumHeight = width / imageRatio
		
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(width),
			heightDimension: .absolute(max(height, minimumHeight))
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			ImageCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		cell.viewModel = ImageCollectionViewCellViewModel(imageUrl: imageUrl)
		return cell
	}
}
