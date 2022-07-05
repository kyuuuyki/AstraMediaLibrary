//
//  MainPresenter.swift
//  AstraMediaLibrary
//

import Foundation
import UIKit

// MARK: - PRESENTATION LOGIC
protocol MainPresenterProtocol {
	func presentSessionStatus(response: MainModel.SessionStatus.Response)
	func presentAstronomyPictureOfTheDay(response: MainModel.AstronomyPictureOfTheDay.Response)
	func presentSuggestedCategoryList(response: MainModel.SuggestedCategoryList.Response)
    func presentRecentMediaList(response: MainModel.RecentMediaList.Response)
	func presentSelectAPOD(response: MainModel.SelectAPOD.Response)
	func presentSelectCategory(response: MainModel.SelectCategory.Response)
	func presentSelectMedia(response: MainModel.SelectMedia.Response)
}

// MARK: - PRESENTER
struct MainPresenter: MainPresenterProtocol {
    weak var viewController: MainViewControllerProtocol?
}

// MARK: - SESSION STATUS
extension MainPresenter {
	func presentSessionStatus(response: MainModel.SessionStatus.Response) {
		let viewModel = MainModel.SessionStatus.ViewModel(
			shouldDisplaySignIn: response.isSignInNeeded,
			shouldDisplaySignUp: response.isSignUpNeeded
		)
		viewController?.displaySessionStatus(viewModel: viewModel)
	}
}

// MARK: - ASTRONOMY PICTURE OF THE DAY
extension MainPresenter {
	func presentAstronomyPictureOfTheDay(response: MainModel.AstronomyPictureOfTheDay.Response) {
		let viewModel = MainModel.AstronomyPictureOfTheDay.ViewModel(apodItem: response.apodItem)
		viewController?.displayAstronomyPictureOfTheDay(viewModel: viewModel)
	}
}

// MARK: - SUGGESTED CATEGORY LIST
extension MainPresenter {
	func presentSuggestedCategoryList(response: MainModel.SuggestedCategoryList.Response) {
		let viewModel = MainModel.SuggestedCategoryList.ViewModel(
			agencies: response.agencies,
			missions: response.missions
		)
		viewController?.displaySuggestedCategoryList(viewModel: viewModel)
	}
}

// MARK: - RECENT MEDIA LIST
extension MainPresenter {
    func presentRecentMediaList(response: MainModel.RecentMediaList.Response) {
		let viewModel = MainModel.RecentMediaList.ViewModel(items: response.items)
        viewController?.displayRecentMediaList(viewModel: viewModel)
    }
}

// MARK: - SELECT APOD
extension MainPresenter {
	func presentSelectAPOD(response: MainModel.SelectAPOD.Response) {
		let viewModel = MainModel.SelectAPOD.ViewModel(item: response.item)
		viewController?.displaySelectAPOD(viewModel: viewModel)
	}
}

// MARK: - SELECT CATEGORY
extension MainPresenter {
	func presentSelectCategory(response: MainModel.SelectCategory.Response) {
		let viewModel = MainModel.SelectCategory.ViewModel(category: response.category)
		viewController?.displaySelectCategory(viewModel: viewModel)
	}
}

// MARK: - SELECT MEDIA
extension MainPresenter {
	func presentSelectMedia(response: MainModel.SelectMedia.Response) {
		let viewModel = MainModel.SelectMedia.ViewModel(item: response.item)
		viewController?.displaySelectMedia(viewModel: viewModel)
	}
}
