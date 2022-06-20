//
//  AstraMediaLibrary.swift
//  AstraMediaLibrary
//

import UIKit

public struct AstraMediaLibrary {
	public private(set) var text = "Hello, World!"
	
	public init() {
	}
}

extension UIImage {
	static var placeHolderImage: UIImage {
		return UIImage(named: "nasa-logo", in: .module, with: nil)!
	}
	
	static var apodPlaceHolderImage: UIImage {
		return UIImage(named: "apod-placeholder", in: .module, with: nil)!
	}
	
	static var safari: UIImage {
		return UIImage(systemName: "safari")!
	}
}

enum DesignSystem {
	enum Effect {
		static let blurStyle: UIBlurEffect.Style = .systemChromeMaterialLight
	}
	
	enum Layer {
		static let cornerRadius: CGFloat = 8
		
		enum Border {
			static let color: CGColor = UIColor.separator.cgColor
			static let width: CGFloat = 1
		}
	}
	
	enum Spacing {
		static let interitem: CGFloat = 10
		
		enum Edge {
			static let normal: CGFloat = 16
			static let bottom: CGFloat = (UIApplication.shared.window?.safeAreaInsets.bottom ?? 0) + normal
		}
	}
	
	enum Ratio {
		static let image: CGFloat = 4 / 3
		static let video: CGFloat = 16 / 9
	}
	
	enum Shadow {
		static let color: CGColor = UIColor.black.cgColor
		static let radius: CGFloat = 8
		static let opacity: Float = 0.25
	}
}
