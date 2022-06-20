//
//  MediaListInteractor.swift
//  AstraMediaLibrary
//

import Foundation

// MARK: - BUSINESS LOGIC
protocol MediaListInteractorProtocol {
	func getMediaListAppearance(request: MediaListModel.MediaListAppearance.Request)
	func getMediaList(request: MediaListModel.MediaList.Request)
	func selectMedia(request: MediaListModel.SelectMedia.Request)
}

// MARK: - INTERACTOR
struct MediaListInteractor: MediaListInteractorProtocol {
	var presenter: MediaListPresenterProtocol?
	var worker: MediaListWorkerProtocol?
	var dataStore: MediaListDataStoreProtocol?
}

// MARK: - MEDIA LIST APPEARANCE
extension MediaListInteractor {
	func getMediaListAppearance(request: MediaListModel.MediaListAppearance.Request) {
		let response = MediaListModel.MediaListAppearance.Response(category: dataStore?.category)
		presenter?.presentMediaListAppearance(response: response)
	}
}

// MARK: - MEDIA LIST
extension MediaListInteractor {
	func getMediaList(request: MediaListModel.MediaList.Request) {
		let group = DispatchGroup()
		
		group.enter()
		worker?.search(keyword: request.keyword, page: 1, completion: { result in
			switch result {
			case .success(let items):
				dataStore?.setItems(items)
			case .failure:
				dataStore?.setItems([])
			}
			group.leave()
		})
		
		group.notify(queue: .main) {
			guard let items = dataStore?.items else { return }
			
			let response = MediaListModel.MediaList.Response(items: items)
			presenter?.presentMediaList(response: response)
		}
	}
}

// MARK: - SELECT MEDIA
extension MediaListInteractor {
	func selectMedia(request: MediaListModel.SelectMedia.Request) {
		guard let item = dataStore?.items[safe: request.index] else { return }
		
		let response = MediaListModel.SelectMedia.Response(item: item)
		presenter?.presentSelectMedia(response: response)
	}
}
