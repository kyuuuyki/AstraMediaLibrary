//
//  MediaDetailPresenter.swift
//  AstraMediaLibrary
//

import Foundation
import UIKit

// MARK: - PRESENTATION LOGIC
protocol MediaDetailPresenterProtocol {
    func presentMediaDetail(response: MediaDetailModel.MediaDetail.Response)
}

// MARK: - PRESENTER
struct MediaDetailPresenter: MediaDetailPresenterProtocol {
    weak var viewController: MediaDetailViewControllerProtocol?
}

// MARK: - DO SOMETHING
extension MediaDetailPresenter {
    func presentMediaDetail(response: MediaDetailModel.MediaDetail.Response) {
		let viewModel = MediaDetailModel.MediaDetail.ViewModel(
			item: response.item,
			assetItem: response.assetItem,
			imageSize: response.imageSize
		)
        viewController?.displayMediaDetail(viewModel: viewModel)
    }
}
