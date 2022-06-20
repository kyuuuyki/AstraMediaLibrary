//
//  AppDelegate.swift
//  AstraMediaLibrary-Client
//

import AVKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let audioSession = AVAudioSession.sharedInstance()
		
		do {
			try audioSession.setCategory(.playback, mode: .moviePlayback)
		} catch  {
			print("Audio session failed")
		}
		
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	
	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		return UISceneConfiguration(
			name: "Default Configuration",
			sessionRole: connectingSceneSession.role
		)
	}
	
	func application(
		_ application: UIApplication,
		didDiscardSceneSessions
		sceneSessions: Set<UISceneSession>
	) {
	}
}
