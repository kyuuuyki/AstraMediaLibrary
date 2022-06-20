//
//  ImageCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

protocol ImageCollectionViewCellViewModelProtocol {
	var imageUrl: URL { get }
}

struct ImageCollectionViewCellViewModel: ImageCollectionViewCellViewModelProtocol {
	let imageUrl: URL
}
