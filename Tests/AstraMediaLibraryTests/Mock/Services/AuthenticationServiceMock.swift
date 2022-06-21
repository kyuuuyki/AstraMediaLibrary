//
//  AuthenticationServiceMock.swift
//  AstraMediaLibrary
//

import AstraCoreModels
import Foundation

class AuthenticationServiceMock: AuthenticationServiceProtocol {
	var sessionStatusCalled = false
	var sessionStatusStub: AuthenticationSessionStatusType!
	func sessionStatus(completion: @escaping (AuthenticationSessionStatusType) -> Void) {
		sessionStatusCalled = true
		completion(sessionStatusStub)
	}
	
	var signInCalled = false
	var signInStub: Result<Bool, Error>!
	func signIn(apiKey: String, completion: @escaping (Result<Bool, Error>) -> Void) {
		signInCalled = true
		completion(signInStub)
	}
	
	var signOutCalled = false
	func signOut(completion: @escaping () -> Void) {
		signOutCalled = true
	}
}
