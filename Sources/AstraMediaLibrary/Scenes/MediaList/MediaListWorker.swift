//
//  MediaListWorker.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

// MARK: - WORKER LOGIC
protocol MediaListWorkerProtocol {
	func search(
		keyword: String,
		page: Int,
		completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void
	)
}

// MARK: - WORKER
struct MediaListWorker: MediaListWorkerProtocol {
	let mediaLibraryService: MediaLibraryServiceProtocol
    
    // MARK: GET - SEARCH
	func search(
		keyword: String,
		page: Int,
		completion: @escaping (Result<[MediaLibraryItemProtocol], Error>) -> Void
	) {
		mediaLibraryService.getMediaListByKeyword(keyword: keyword, page: page) { result in
			switch result {
			case .success(let items):
				completion(.success(items.sorted(by: { $0.createdAt > $1.createdAt })))
			case .failure:
				completion(.success([]))
			}
		}
    }
}
