//
//  MainCompositionalLayout.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import KyuGenericExtensions
import UIKit

struct MainCompositionalLayout: KSPCollectionViewCompositionalLayoutProtocol {
	var sections: [KSPCollectionViewCompositionalLayoutSectionProtocol]
	
	init(
		astronomyPictureOfTheDayViewModel: MainModel.AstronomyPictureOfTheDay.ViewModel?,
		suggestedCategoryListViewModel: MainModel.SuggestedCategoryList.ViewModel?,
		recentMediaListViewModel: MainModel.RecentMediaList.ViewModel?
	) {
		guard astronomyPictureOfTheDayViewModel != nil else {
			self.sections = [MainActivityIndicatorSection(shouldAnimated: true)]
			return
		}
		
		var sections = [KSPCollectionViewCompositionalLayoutSectionProtocol]()
		
		if let apodItem = astronomyPictureOfTheDayViewModel?.apodItem {
			sections.append(MainAPODSection(apodItem: apodItem))
		} else {
			sections.append(MainAPODSection(apodItem: PlaceholderAPODItem()))
		}
		
		if let categories = suggestedCategoryListViewModel?.categories, !categories.isEmpty {
			sections.append(MainCategoryListSection(categories: categories))
		}
		
		if let missions = suggestedCategoryListViewModel?.missions, !missions.isEmpty {
			sections.append(MainMissionListSection(missions: missions))
		}
		
		if let items = recentMediaListViewModel?.items {
			sections.append(MediaListSection(items: items))
		} else {
			sections.append(ActivityIndicatorSection(shouldAnimated: true))
		}
		
		self.sections = sections
	}
}
