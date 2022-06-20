//
//  ViewController.swift
//  AstraMediaLibrary-Client
//

import AstraCoreAPI
import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let authenticationService = AstraCoreAPI.coreAPI().authenticationService()
		authenticationService.signIn(
			apiKey: "DEMO_KEY"
		) { _ in
			Assembler.assembler().reconfigure()
		}
	}
}
