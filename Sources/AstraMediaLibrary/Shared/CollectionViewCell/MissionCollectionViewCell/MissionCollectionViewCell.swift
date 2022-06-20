//
//  MissionCollectionViewCell.swift
//  AstraMediaLibrary
//

import Foundation
import SDWebImage
import UIKit

class MissionCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	var viewModel: MissionCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellImageView: UIImageView!
	@IBOutlet private weak var cellTitleLabel: UILabel!
	@IBOutlet private weak var cellDescriptionLabel: UILabel!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension MissionCollectionViewCell {
	func configureView() {
		backgroundColor = .secondarySystemBackground
		layer.cornerRadius = DesignSystem.Layer.cornerRadius
		layer.borderWidth = DesignSystem.Layer.Border.width
		layer.borderColor = DesignSystem.Layer.Border.color
		
		cellTitleLabel.font = .preferredFont(forTextStyle: .subheadline)
		cellDescriptionLabel.font = .preferredFont(forTextStyle: .caption1)
		cellDescriptionLabel.textColor = .secondaryLabel
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		cellTitleLabel.text = viewModel.title
		cellDescriptionLabel.text = viewModel.description
		
		cellImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
		cellImageView.sd_setImage(
			with: viewModel.imageUrl,
			placeholderImage: .placeHolderImage,
			options: [.retryFailed]
		)
	}
}
