//
//  MediaDetailViewController+CollectionView.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - UICOLLECTIONVIEW DELEGATE, UICOLLECTIONVIEW DATASOURCE
extension MediaDetailViewController {
	func configureCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.contentInsetAdjustmentBehavior = .never
	}
	
	func configureCollectionViewLayout() {
		if let videoUrl = mediaDetailViewModel?.assetItem?.url {
			updateAVPlayerViewController(videoUrl: videoUrl)
		}
		
		collectionViewLayout = MediaDetailCompositionalLayout(
			playerViewController: playerViewController,
			mediaDetailViewModel: mediaDetailViewModel
		)
		reloadCollectionViewData(collectionView: collectionView, animated: false, completion: nil)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		guard let section = collectionViewLayout?.sections[safe: indexPath.section] else { return }
		
		switch section {
		case is MediaDetailInfoSection:
			if let section = section as? MediaDetailInfoSection,
			   let url = section.contents[safe: indexPath.item]?.url {
				router?.navigateToSafari(url: url)
			}
		default:
			break
		}
	}
}

// MARK: - PARALLAXABLE
extension MediaDetailViewController {
	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		if let cell = cell as? KSPParallaxable {
			parallaxableConstraint = cell.parallaxableConstraint
		}
		
		if let section = collectionViewLayout?.sections[safe: indexPath.section],
		   section is MediaDetailVideoSection {
			cell.layer.cornerRadius = DesignSystem.Layer.cornerRadius
			cell.layer.borderWidth = DesignSystem.Layer.Border.width
			cell.layer.borderColor = DesignSystem.Layer.Border.color
		}
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y <= 0 {
			parallaxableConstraint?.constant = scrollView.contentOffset.y
		} else {
			parallaxableConstraint?.constant = 0
		}
	}
}
