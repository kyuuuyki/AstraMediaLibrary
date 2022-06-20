//
//  APODCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import KyuGenericExtensions
import SDWebImage
import UIKit

class APODCollectionViewCell: UICollectionViewCell, KSPParallaxable {
	// MARK: MODEL
	var viewModel: APODCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellImageView: UIImageView!
	@IBOutlet private weak var cellTitleLabel: UILabel!
	@IBOutlet private weak var cellVideoContainerView: UIView!
	@IBOutlet private weak var cellRandomBadgeContainerView: UIView!
	@IBOutlet private weak var cellVideoContainerViewTopConstraint: NSLayoutConstraint!
	
	// swiftlint:disable:next private_outlet
	@IBOutlet weak var parallaxableConstraint: NSLayoutConstraint!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension APODCollectionViewCell {
	func configureView() {
		clipsToBounds = false
		contentView.clipsToBounds = false
		
		cellVideoContainerView.isHidden = true
		
		cellRandomBadgeContainerView.isHidden = true
		cellRandomBadgeContainerView.backgroundColor = .clear
		cellRandomBadgeContainerView.layer.cornerRadius = DesignSystem.Layer.cornerRadius / 4
		cellRandomBadgeContainerView.insertBlurredBackground(withStyle: DesignSystem.Effect.blurStyle)
		
		let height = UIApplication.shared.window?.safeAreaInsets.top ?? 0
		cellVideoContainerViewTopConstraint.constant = -height
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		parallaxableConstraint.constant = 0
		
		cellTitleLabel.setTextColor(forBackgroundColor: .black)
		cellVideoContainerView.isHidden = true
		cellRandomBadgeContainerView.isHidden = !viewModel.shouldDisplayRandomBadge
		
		cellImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
		cellImageView.sd_setImage(
			with: viewModel.imageUrl,
			placeholderImage: .placeHolderImage,
			options: [.retryFailed]
		) { [weak self] image, _, _, _ in
			guard let self = self else { return }
			
			let imageColor = image?.averageColor ?? .black
			self.cellTitleLabel.setTextColor(forBackgroundColor: imageColor)
		}
	}
}
