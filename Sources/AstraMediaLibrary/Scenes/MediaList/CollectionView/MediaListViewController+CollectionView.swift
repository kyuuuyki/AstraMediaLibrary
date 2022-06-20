//
//  MediaListViewController+CollectionView.swift
//  AstraMediaLibrary
//

import Foundation
import UIKit

// MARK: - UICOLLECTIONVIEW DELEGATE, UICOLLECTIONVIEW DATASOURCE
extension MediaListViewController {
	func configureCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	func configureCollectionViewLayout() {
		collectionViewLayout = MediaListCompositionalLayout(
			mediaListAppearanceViewModel: mediaListAppearanceViewModel,
			mediaListViewModel: mediaListViewModel,
			shouldDisplayActivityIndicator: shouldDisplayActivityIndicator
		)
		reloadCollectionViewData(collectionView: collectionView, animated: false, completion: nil)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let section = collectionViewLayout?.sections[safe: indexPath.section] else { return }
		
		switch section {
		case is MediaListInfoSection:
			if let section = section as? MediaListInfoSection,
			   let url = section.contents[safe: indexPath.item]?.url {
				router?.navigateToSafari(url: url)
			}
		case is MediaListSection:
			selectMedia(index: indexPath.item)
		default:
			break
		}
	}
}
