//
//  MediaDetailInfoSection.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MediaDetailInfoSection: KSPInfoSectionProtocol {
	let contents: [KSPInfoSectionContentProtocol]
	
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
		section.contentInsets.top = DesignSystem.Spacing.Edge.normal / 4
		section.contentInsets.leading = DesignSystem.Spacing.Edge.normal
		section.contentInsets.trailing = DesignSystem.Spacing.Edge.normal
		section.contentInsets.bottom = DesignSystem.Spacing.Edge.bottom
		return section
	}
}

extension MediaDetailInfoSection {
	init(item: MediaLibraryItemProtocol) {
		var contents = [KSPInfoSectionContentProtocol]()
		
		// NASA ID
		if !item.id.isEmpty {
			let idContent = MediaDetailInfoSectionContent(
				title: "NASA ID",
				description: item.id,
				image: nil,
				url: nil
			)
			contents.append(idContent)
		}
		
		// Center
		if !item.center.isEmpty {
			let centerContent = MediaDetailInfoSectionContent(
				title: "Center",
				description: item.center,
				image: nil,
				url: nil
			)
			contents.append(centerContent)
		}
		
		// Keywords
		if !item.keywords.isEmpty {
			let keywordsContent = MediaDetailInfoSectionContent(
				title: "Keywords",
				description: item.keywords.joined(separator: ", "),
				image: nil,
				url: nil
			)
			contents.append(keywordsContent)
		}
		
		// Date Created
		let dateContent = MediaDetailInfoSectionContent(
			title: "Date Created",
			description: String(date: item.createdAt, format: "yyyy-MM-dd"),
			image: nil,
			url: nil
		)
		contents.append(dateContent)
		
		// Informational Website
		if let url = item.link {
			let content = MediaDetailInfoSectionContent(
				title: "Informational Website",
				description: nil,
				image: .safari,
				url: url
			)
			contents.append(content)
		}
		
		self.contents = contents
	}
}

struct MediaDetailInfoSectionContent: KSPInfoSectionContentProtocol {
	let title: String
	let description: String?
	let font: UIFont = .systemFont(ofSize: 15)
	let image: UIImage?
	let url: URL?
}
