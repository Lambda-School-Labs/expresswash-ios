//
//  SignUpTests.swift
//  ExpressWashTests
//
//  Created by Bobby Keffury on 5/11/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import XCTest
@testable import ExpressWash

class SignUpTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testRegistration() throws {
//
//        let firstName = "John"
//        let lastName = "Doe"
//        let email = "John.Doe@gmail.com"
//        let password = "Password!"
//
//        let expect = expectation(description: "User registered")
//
//        UserController.shared.registerUser(with: firstName, lastName, email, password) { (user, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//
//            guard let user = user else { return }
//
//            XCTAssertTrue(user.firstName == firstName)
//            XCTAssertTrue(user.lastName == lastName)
//            XCTAssertTrue(user.email == email)
//            expect.fulfill()
//        }
//
//        waitForExpectations(timeout: 3.0, handler: nil)
//
//    }

}
