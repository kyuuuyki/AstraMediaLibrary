//
//  MediaListCompositionalLayout.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MediaListCompositionalLayout: KSPCollectionViewCompositionalLayoutProtocol {
	var sections: [KSPCollectionViewCompositionalLayoutSectionProtocol]
	
	init(
		mediaListAppearanceViewModel: MediaListModel.MediaListAppearance.ViewModel?,
		mediaListViewModel: MediaListModel.MediaList.ViewModel?,
		shouldDisplayActivityIndicator: Bool
	) {
		var sections = [KSPCollectionViewCompositionalLayoutSectionProtocol]()
		
		if let description = mediaListAppearanceViewModel?.description {
			sections.append(
				MediaListDescriptionSection(
					text: description,
					textColor: .secondaryLabel,
					font: .preferredFont(forTextStyle: .body)
				)
			)
		}
		
		if let url = mediaListAppearanceViewModel?.link {
			let content = MediaListInfoSectionContent(
				title: "Informational Website",
				description: nil,
				image: .safari,
				url: url
			)
			
			sections.append(
				MediaListInfoSection(contents: [content])
			)
		}
		
		if let items = mediaListViewModel?.items {
			sections.append(MediaListSection(items: items))
		}
		
		if shouldDisplayActivityIndicator {
			sections.append(ActivityIndicatorSection(shouldAnimated: true))
		}
		
		self.sections = sections
	}
}
