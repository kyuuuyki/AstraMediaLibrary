//
//  MainInteractor.swift
//  AstraMediaLibrary
//

import Foundation

// MARK: - BUSINESS LOGIC
protocol MainInteractorProtocol {
	func getSessionStatus(request: MainModel.SessionStatus.Request)
	func selectAPOD(request: MainModel.SelectAPOD.Request)
	func getAstronomyPictureOfTheDay(request: MainModel.AstronomyPictureOfTheDay.Request)
	func getSuggestedCategoryList(request: MainModel.SuggestedCategoryList.Request)
	func getRecentMediaList(request: MainModel.RecentMediaList.Request)
	func selectCategory(request: MainModel.SelectCategory.Request)
	func selectMedia(request: MainModel.SelectMedia.Request)
}

// MARK: - INTERACTOR
struct MainInteractor: MainInteractorProtocol {
	var presenter: MainPresenterProtocol?
	var worker: MainWorkerProtocol?
	var dataStore: MainDataStoreProtocol?
}

// MARK: - SESSION STATUS
extension MainInteractor {
	func getSessionStatus(request: MainModel.SessionStatus.Request) {
		let group = DispatchGroup()
		var isSignedIn = false
		
		group.enter()
		worker?.getSessionStatus(completion: { status in
			switch status {
			case .signedIn:
				isSignedIn = true
			case .signedOut:
				isSignedIn = false
			}
			group.leave()
		})
		
		group.notify(queue: .main) {
			let response = MainModel.SessionStatus.Response(isSignedIn: isSignedIn)
			presenter?.presentSessionStatus(response: response)
		}
	}
}

// MARK: - ASTRONOMY PICTURE OF THE DAY
extension MainInteractor {
	func getAstronomyPictureOfTheDay(request: MainModel.AstronomyPictureOfTheDay.Request) {
		let group = DispatchGroup()
		
		group.enter()
		worker?.getAstronomyPictureOfTheDay(completion: { result in
			switch result {
			case .success(let item):
				dataStore?.setAPODItem(item)
			case .failure:
				dataStore?.setAPODItem(nil)
			}
			group.leave()
		})
		
		group.notify(queue: .main) {
			let response = MainModel.AstronomyPictureOfTheDay.Response(apodItem: dataStore?.apodItem)
			presenter?.presentAstronomyPictureOfTheDay(response: response)
		}
	}
}

// MARK: - SELECT APOD
extension MainInteractor {
	func selectAPOD(request: MainModel.SelectAPOD.Request) {
		guard let apodItem = dataStore?.apodItem else { return }
		let item = APODItem(apodItem: apodItem)
		let response = MainModel.SelectAPOD.Response(item: item)
		presenter?.presentSelectAPOD(response: response)
	}
}

// MARK: - SUGGESTED CATEGORY LIST
extension MainInteractor {
	func getSuggestedCategoryList(request: MainModel.SuggestedCategoryList.Request) {
		let group = DispatchGroup()
		
		group.enter()
		worker?.getSuggestedCategoryList(completion: { result in
			switch result {
			case .success(let suggestedCategories):
				let missions = suggestedCategories.filter({ $0.categoryType == .mission })
				let categories = suggestedCategories.filter({ $0.categoryType != .mission })
				
				dataStore?.setMissions(missions)
				dataStore?.setCategories(categories)
			case .failure:
				dataStore?.setMissions([])
				dataStore?.setCategories([])
			}
			group.leave()
		})
		
		group.notify(queue: .main) {
			guard let categories = dataStore?.categories,
				  let missions = dataStore?.missions
			else {
				return
			}
			
			let response = MainModel.SuggestedCategoryList.Response(
				categories: categories,
				missions: missions
			)
			presenter?.presentSuggestedCategoryList(response: response)
		}
	}
}

// MARK: - RECENT MEDIA LIST
extension MainInteractor {
	func getRecentMediaList(request: MainModel.RecentMediaList.Request) {
		let group = DispatchGroup()
		
		group.enter()
		worker?.getRecentMediaList(completion: { result in
			switch result {
			case .success(let items):
				dataStore?.setRecentItems(items)
			case .failure:
				dataStore?.setRecentItems([])
			}
			
			group.leave()
		})
		
		group.notify(queue: .main) {
			guard let items = dataStore?.recentItems else { return }
			
			let response = MainModel.RecentMediaList.Response(items: items)
			presenter?.presentRecentMediaList(response: response)
		}
	}
}

// MARK: - SELECT CATEGORY
extension MainInteractor {
	func selectCategory(request: MainModel.SelectCategory.Request) {
		let category = dataStore?.categories[safe: request.index]
		let mission = dataStore?.missions[safe: request.index]
		
		let selectedCategory = request.isMission ? mission : category
		guard let selectedCategory = selectedCategory else { return }
		
		let response = MainModel.SelectCategory.Response(category: selectedCategory)
		presenter?.presentSelectCategory(response: response)
	}
}

// MARK: - SELECT MEDIA
extension MainInteractor {
	func selectMedia(request: MainModel.SelectMedia.Request) {
		guard let item = dataStore?.recentItems[safe: request.index] else { return }
		
		let response = MainModel.SelectMedia.Response(item: item)
		presenter?.presentSelectMedia(response: response)
	}
}
