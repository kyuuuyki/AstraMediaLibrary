//
//  MediaDetailVideoSection.swift
//  AstraMediaLibrary
//

import AVKit
import Foundation
import KyuGenericExtensions
import UIKit

struct MediaDetailVideoSection: KSPVideoSectionProtocol {
	let playerViewController: AVPlayerViewController?
	
	private let videoRatio: CGFloat = DesignSystem.Ratio.video
	
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
			heightDimension: .fractionalWidth(1 / videoRatio)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		return section
	}
}
