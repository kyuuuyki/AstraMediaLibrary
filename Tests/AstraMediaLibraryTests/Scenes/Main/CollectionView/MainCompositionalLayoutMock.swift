//
//  MainCompositionalLayoutMock.swift
//  AstraMediaLibrary
//

@testable import AstraMediaLibrary
import Foundation
import KyuGenericExtensions

struct MainCompositionalLayoutMock: KSPCollectionViewCompositionalLayoutProtocol {
	var sections: [KSPCollectionViewCompositionalLayoutSectionProtocol] {
		var sections = [KSPCollectionViewCompositionalLayoutSectionProtocol]()
		
		let apodItem = MediaLibraryAPODItemMock()
		sections.append(MainAPODSection(apodItem: apodItem))
		
		let agency = MediaLibraryCategoryAgencyMock()
		sections.append(MainCategoryListSection(categories: [agency]))
		
		let mission = MediaLibraryCategoryMissionMock()
		sections.append(MainMissionListSection(missions: [mission]))
		
		let item = MediaLibraryItemMock()
		sections.append(MediaListSection(items: [item]))
		
		return sections
	}
}

enum MainCompositionalLayoutMockSectionIndex: Int {
	case apod = 0
	case categoryAgency = 1
	case categoryMission = 2
	case media = 3
}
