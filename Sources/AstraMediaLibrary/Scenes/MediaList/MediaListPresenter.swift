//
//  MediaListPresenter.swift
//  AstraMediaLibrary
//

import Foundation
import UIKit

// MARK: - PRESENTATION LOGIC
protocol MediaListPresenterProtocol {
	func presentMediaListAppearance(response: MediaListModel.MediaListAppearance.Response)
    func presentMediaList(response: MediaListModel.MediaList.Response)
	func presentSelectMedia(response: MediaListModel.SelectMedia.Response)
}

// MARK: - PRESENTER
struct MediaListPresenter: MediaListPresenterProtocol {
    weak var viewController: MediaListViewControllerProtocol?
}

// MARK: - MEDIA LIST APPEARANCE
extension MediaListPresenter {
	func presentMediaListAppearance(response: MediaListModel.MediaListAppearance.Response) {
		let keyword = response.category?.key
		let title = response.category?.title ?? "Search"
		let description = response.category?.description
		let link = response.category?.link
		let shouldDisplaySearchBar = response.category?.key == nil
		
		let viewModel = MediaListModel.MediaListAppearance.ViewModel(
			keyword: keyword,
			title: title,
			description: description,
			link: link,
			shouldDisplaySearchBar: shouldDisplaySearchBar
		)
		viewController?.displayMediaListAppearance(viewModel: viewModel)
	}
}

// MARK: - MEDIA LIST
extension MediaListPresenter {
    func presentMediaList(response: MediaListModel.MediaList.Response) {
		let viewModel = MediaListModel.MediaList.ViewModel(items: response.items)
        viewController?.displayMediaList(viewModel: viewModel)
    }
}

// MARK: - SELECT MEDIA
extension MediaListPresenter {
	func presentSelectMedia(response: MediaListModel.SelectMedia.Response) {
		let viewModel = MediaListModel.SelectMedia.ViewModel(item: response.item)
		viewController?.displaySelectMedia(viewModel: viewModel)
	}
}
