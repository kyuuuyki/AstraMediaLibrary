//
//  MediaCollectionViewCell.swift
//  AstraMediaLibrary
//

import Foundation
import KyuGenericExtensions
import SDWebImage
import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	var viewModel: MediaCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellContainerView: UIView!
	@IBOutlet private weak var cellImageView: UIImageView!
	@IBOutlet private weak var cellTitleLabelContainerView: UIView!
	@IBOutlet private weak var cellTitleLabel: UILabel!
	@IBOutlet private weak var cellSubtitleLabel: UILabel!
	@IBOutlet private weak var cellVideoIndicatorImageView: UIImageView!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension MediaCollectionViewCell {
	func configureView() {
		cellContainerView.backgroundColor = .clear
		cellContainerView.clipsToBounds = true
		
		cellTitleLabel.font = .preferredFont(forTextStyle: .headline)
		cellTitleLabel.textColor = .label
		cellSubtitleLabel.font = .preferredFont(forTextStyle: .caption2)
		cellSubtitleLabel.textColor = .secondaryLabel
		cellTitleLabelContainerView.backgroundColor = .clear
		
		cellVideoIndicatorImageView.isHidden = true
		cellVideoIndicatorImageView.layer.shadowColor = DesignSystem.Shadow.color
		cellVideoIndicatorImageView.layer.shadowRadius = DesignSystem.Shadow.radius / 2
		cellVideoIndicatorImageView.layer.shadowOpacity = DesignSystem.Shadow.opacity
		cellVideoIndicatorImageView.layer.masksToBounds = false
		
		cellImageView.layer.cornerRadius = DesignSystem.Layer.cornerRadius
		cellImageView.layer.borderColor = DesignSystem.Layer.Border.color
		cellImageView.layer.borderWidth = DesignSystem.Layer.Border.width
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		cellTitleLabel.text = viewModel.title
		cellSubtitleLabel.text = viewModel.subtitle
		cellVideoIndicatorImageView.isHidden = !viewModel.shouldDisplayVideoIndicator
		
		cellImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
		cellImageView.sd_setImage(
			with: viewModel.imageUrl,
			placeholderImage: .placeHolderImage,
			options: [.retryFailed]
		)
	}
}
