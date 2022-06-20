//
//  MediaDetailWorker.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import SDWebImage
import UIKit

// MARK: - WORKER LOGIC
protocol MediaDetailWorkerProtocol {
	func asset(
		id: String,
		completion: @escaping (Result<[MediaLibraryAssetItemProtocol], Error>) -> Void
	)
	
	func image(imageUrl: URL?, completion: @escaping (Result<UIImage, Error>) -> Void)
}

// MARK: - WORKER
struct MediaDetailWorker: MediaDetailWorkerProtocol {
	let mediaLibraryService: MediaLibraryServiceProtocol
	
    // MARK: GET - ASSET
	func asset(
		id: String,
		completion: @escaping (Result<[MediaLibraryAssetItemProtocol], Error>) -> Void
	) {
		mediaLibraryService.asset(id: id, completion: completion)
    }
	
	func image(imageUrl: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
		SDWebImageManager.shared.loadImage(
			with: imageUrl,
			progress: nil
		) { image, _, _, _, _, _ in
			if let image = image {
				completion(.success(image))
			} else {
				completion(.success(.placeHolderImage))
			}
		}
	}
}
