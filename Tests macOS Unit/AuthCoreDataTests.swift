//
//  Tests_macOS_Unit.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 17.11.20.
//

import XCTest
@testable import Chimp

class AuthStateTests: XCTestCase {
    
    private var context: NSManagedObjectContext?
    private var authState = AuthState()

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = true
    }
    
    func test_check_auth() throws {
        let authState = AuthState()
        authState.checkAuth()
        XCTAssertTrue(!authState.loggedIn, "user ist not logged in")
    }
    
    func test_auth_user() throws {
        let authState = AuthState()
        authState.authUser(email: "testmail@web.de", password: "testpassword@web.de", option: .signIn, viewContext: <#T##NSManagedObjectContext#>)
    }
}
