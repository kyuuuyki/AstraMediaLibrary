//
//  MainViewController+CollectionView.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - UICOLLECTIONVIEW DELEGATE, UICOLLECTIONVIEW DATASOURCE
extension MainViewController {
	func configureCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.alwaysBounceVertical = true
		collectionView.contentInsetAdjustmentBehavior = .never
		configureRefreshControl()
	}
	
	func configureCollectionViewLayout() {
		guard !isFetchingData else { return }
		
		collectionViewLayout = MainCompositionalLayout(
			astronomyPictureOfTheDayViewModel: astronomyPictureOfTheDayViewModel,
			suggestedCategoryListViewModel: suggestedCategoryListViewModel,
			recentMediaListViewModel: recentMediaListViewModel
		)
		reloadCollectionViewData(collectionView: collectionView, animated: false, completion: nil)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let section = collectionViewLayout?.sections[safe: indexPath.section] else { return }
		
		switch section {
		case is MainAPODSection:
			selectAPOD()
		case is MainCategoryListSection:
			selectCategory(index: indexPath.item, isMission: false)
		case is MainMissionListSection:
			selectCategory(index: indexPath.item, isMission: true)
		case is MediaListSection:
			selectMedia(index: indexPath.item)
		default:
			break
		}
	}
}

// MARK: - REFRESHCONTROL
extension MainViewController {
	func configureRefreshControl() {
		collectionView.refreshControl = UIRefreshControl()
		guard let refreshControl = collectionView.refreshControl else { return }
		let safeAreaInsets = UIApplication.application().window?.safeAreaInsets ?? .zero
		refreshControl.bounds.origin.y = -safeAreaInsets.top
		refreshControl.layer.zPosition = .greatestFiniteMagnitude
	}
	
	func endRefreshing(completion: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			guard let self = self else { return }
			self.collectionView.refreshControl?.endRefreshing()
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
				self.isFetchingData = false
				completion()
			}
		}
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		guard let refreshControl = collectionView.refreshControl else { return }
		if !isFetchingData && refreshControl.isRefreshing == true {
			getSessionStatus()
		}
	}
}

// MARK: - PARALLAXABLE
extension MainViewController {
	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		if let cell = cell as? KSPParallaxable {
			parallaxableConstraint = cell.parallaxableConstraint
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
