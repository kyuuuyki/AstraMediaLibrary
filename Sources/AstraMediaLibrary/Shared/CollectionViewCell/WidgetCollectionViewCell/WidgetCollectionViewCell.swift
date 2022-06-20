//
//  WidgetCollectionViewCell.swift
//  AstraMediaLibrary
//

import Foundation
import SDWebImage
import UIKit

class WidgetCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	var viewModel: WidgetCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellImageView: UIImageView!
	@IBOutlet private weak var cellTitleLabel: UILabel!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension WidgetCollectionViewCell {
	func configureView() {
		cellImageView.layer.cornerRadius = DesignSystem.Layer.cornerRadius
		cellImageView.layer.borderWidth = DesignSystem.Layer.Border.width
		cellImageView.layer.borderColor = DesignSystem.Layer.Border.color
		
		cellTitleLabel.font = .preferredFont(forTextStyle: .caption1)
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		cellTitleLabel.text = viewModel.title
		
		cellImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
		cellImageView.sd_setImage(
			with: viewModel.imageUrl,
			placeholderImage: .placeHolderImage,
			options: [.retryFailed]
		)
	}
}
