//
//  ImageCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import KyuGenericExtensions
import SDWebImage
import UIKit

class ImageCollectionViewCell: UICollectionViewCell, KSPParallaxable {
	// MARK: MODEL
	var viewModel: ImageCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellImageView: UIImageView!
	
	// swiftlint:disable:next private_outlet
	@IBOutlet weak var parallaxableConstraint: NSLayoutConstraint!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension ImageCollectionViewCell {
	func configureView() {
		clipsToBounds = false
		contentView.clipsToBounds = false
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		parallaxableConstraint.constant = 0
		cellImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
		cellImageView.sd_setImage(
			with: viewModel.imageUrl,
			placeholderImage: .placeHolderImage,
			options: [.retryFailed]
		)
	}
}
