//
//  MediaDetailCompositionalLayout.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import AVKit
import Foundation
import KyuGenericExtensions
import UIKit

struct MediaDetailCompositionalLayout: KSPCollectionViewCompositionalLayoutProtocol {
	var sections: [KSPCollectionViewCompositionalLayoutSectionProtocol]
	
	init(
		playerViewController: AVPlayerViewController?,
		mediaDetailViewModel: MediaDetailModel.MediaDetail.ViewModel?
	) {
		var sections = [KSPCollectionViewCompositionalLayoutSectionProtocol]()
		
		if let item = mediaDetailViewModel?.item {
			if let imageUrl = item.imageUrl, let imageSize = mediaDetailViewModel?.imageSize {
				sections.append(
					MediaDetailPhotoSection(imageUrl: imageUrl, imageSize: imageSize)
				)
			} else {
				sections.append(
					MediaDetailPhotoGallerySection(
						imageUrls: []
					)
				)
			}
			
			sections.append(
				MediaDetailTitleSection(
					text: item.title,
					textColor: .label,
					font: .preferredFont(forTextStyle: .headline)
				)
			)
			
			let dateString = String(date: item.createdAt, format: "EEEE, MMM d, yyyy")
			let detailText = item.center + " · " + dateString
			sections.append(
				MediaDetailDateSection(
					text: detailText,
					textColor: .secondaryLabel,
					font: .preferredFont(forTextStyle: .caption1)
				)
			)
			
			if mediaDetailViewModel?.assetItem != nil,
			   let playerViewController = playerViewController {
				sections.append(
					MediaDetailVideoSection(
						playerViewController: playerViewController
					)
				)
			}
			
			sections.append(
				MediaDetailDescriptionSection(
					text: item.description,
					textColor: .secondaryLabel,
					font: .preferredFont(forTextStyle: .body)
				)
			)
			
			if let item = mediaDetailViewModel?.item {
				sections.append(
					MediaDetailTitleSection(
						text: "Information",
						textColor: .label,
						font: .preferredFont(forTextStyle: .headline)
					)
				)
				
				sections.append(
					MediaDetailInfoSection(item: item)
				)
			}
		} else {
			sections.append(MediaDetailActivityIndicatorSection(shouldAnimated: true))
		}
		
		self.sections = sections
	}
}
