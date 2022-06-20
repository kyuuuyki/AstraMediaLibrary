//
//  MainAPODSection.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MainAPODSection: KSPCollectionViewCompositionalLayoutSectionProtocol {
	let apodItem: MediaLibraryAPODItemProtocol
	private let imageRatio: CGFloat = DesignSystem.Ratio.image
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(
			APODCollectionViewCell.self,
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
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalWidth(1 / imageRatio)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .paging
		return section
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			APODCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		cell.viewModel = APODCollectionViewCellViewModel(item: apodItem)
		return cell
	}
}

struct PlaceholderAPODItem: MediaLibraryAPODItemProtocol {
	var date = Date()
	var title = ""
	var description: String?
	var imageUrl = URL(string: "https://apod.nasa.gov/apod/image/1911/BeanConrad_Apollo12_960.jpg")!
	var imageHDUrl: URL?
	var link = URL(string: "https://apod.nasa.gov")
	var mediaType: MediaLibraryMediaType = .image
}

struct APODItem: MediaLibraryItemProtocol {
	let id: String
	let title: String
	let description: String
	let imageUrl: URL?
	var link: URL?
	let center: String
	let keywords: [String]
	let createdAt: Date
	let mediaType: MediaLibraryMediaType
	
	init(apodItem: MediaLibraryAPODItemProtocol) {
		id = ""
		title = apodItem.title
		description = apodItem.description ?? "Discover the cosmos! Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer." // swiftlint:disable:this line_length
		imageUrl = apodItem.imageUrl
		link = apodItem.link
		center = "APOD"
		keywords = []
		createdAt = apodItem.date
		mediaType = .image
	}
}
