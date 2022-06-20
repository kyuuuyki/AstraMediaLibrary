//
//  MediaListModel.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

enum MediaListModel {
	// MARK: - MEDIA LIST APPEARANCE
	enum MediaListAppearance {
		struct Request {
		}
		
		struct Response {
			let category: MediaLibraryCategoryProtocol?
		}
		
		struct ViewModel {
			let keyword: String?
			
			let title: String
			let description: String?
			let link: URL?
			let shouldDisplaySearchBar: Bool
		}
	}
	
    // MARK: - MEDIA LIST
    enum MediaList {
        struct Request {
			let keyword: String
        }
        
        struct Response {
			let items: [MediaLibraryItemProtocol]
        }
        
        struct ViewModel {
			let items: [MediaLibraryItemProtocol]
        }
    }
	
	// MARK: - SELECT MEDIA
	enum SelectMedia {
		struct Request {
			let index: Int
		}
		
		struct Response {
			let item: MediaLibraryItemProtocol
		}
		
		struct ViewModel {
			let item: MediaLibraryItemProtocol
		}
	}
}
