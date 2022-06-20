//
//  MediaDetailModel.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation
import UIKit

enum MediaDetailModel {
    // MARK: - GET MEDIA DETAIL
    enum MediaDetail {
        struct Request {
        }
        
        struct Response {
			let item: MediaLibraryItemProtocol
			let assetItem: MediaLibraryAssetItemProtocol?
			let imageSize: CGSize
        }
        
        struct ViewModel {
			let item: MediaLibraryItemProtocol
			let assetItem: MediaLibraryAssetItemProtocol?
			let imageSize: CGSize
        }
    }
}
