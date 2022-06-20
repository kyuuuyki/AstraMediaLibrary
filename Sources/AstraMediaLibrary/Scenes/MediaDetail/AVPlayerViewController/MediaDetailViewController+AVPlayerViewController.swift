//
//  MediaDetailViewController+AVPlayerViewController.swift
//  AstraMediaLibrary
//

import AVKit
import Foundation

// MARK: - AVPLAYER VIEWCONTROLLER DELEGATE
extension MediaDetailViewController: AVPlayerViewControllerDelegate {
	func configureAVPlayerViewController() {
		playerViewController = AVPlayerViewController()
		playerViewController?.didMove(toParent: self)
	}
	
	func updateAVPlayerViewController(videoUrl: URL) {
		playerViewController?.player = AVPlayer(url: videoUrl)
		playerViewController?.allowsPictureInPicturePlayback = true
		playerViewController?.player?.play()
	}
}
