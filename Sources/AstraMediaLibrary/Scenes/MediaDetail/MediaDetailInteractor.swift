//
//  MediaDetailInteractor.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import UIKit

// MARK: - BUSINESS LOGIC
protocol MediaDetailInteractorProtocol {
	func getMediaDetail(request: MediaDetailModel.MediaDetail.Request)
}

// MARK: - INTERACTOR
struct MediaDetailInteractor: MediaDetailInteractorProtocol {
	var presenter: MediaDetailPresenterProtocol?
	var worker: MediaDetailWorkerProtocol?
	var dataStore: MediaDetailDataStoreProtocol?
}

// MARK: - MEDIA DETAIL
extension MediaDetailInteractor {
	func getMediaDetail(request: MediaDetailModel.MediaDetail.Request) {
		guard let item = dataStore?.item else { return }
		
		let group = DispatchGroup()
		
		switch item.mediaType {
		case .video:
			group.enter()
			worker?.asset(id: item.id, completion: { result in
				switch result {
				case .success(let assets):
					let video = assets.first(
						where: { $0.url.absoluteString.contains(string: ".mp4") }
					)
					
					let largeVideo = assets.first(
						where: { $0.url.absoluteString.contains(string: "large.mp4") }
					)
					
					let mediumVideo = assets.first(
						where: { $0.url.absoluteString.contains(string: "medium.mp4") }
					)
					
					dataStore?.setAssetItem(mediumVideo ?? largeVideo ?? video)
				case .failure:
					dataStore?.setAssetItem(nil)
				}
				group.leave()
			})
		case .image:
			break
		}
		
		group.enter()
		worker?.image(imageUrl: item.imageUrl, completion: { result in
			switch result {
			case .success(let image):
				dataStore?.setItemImage(image)
			case .failure:
				dataStore?.setItemImage(nil)
			}
			group.leave()
		})
		
		group.notify(queue: .main) {
			guard let itemImage = dataStore?.itemImage else { return }
			let assetItem = dataStore?.assetItem
			let imageSize = itemImage.size
			
			let response = MediaDetailModel.MediaDetail.Response(
				item: item,
				assetItem: assetItem,
				imageSize: imageSize
			)
			presenter?.presentMediaDetail(response: response)
		}
	}
}
