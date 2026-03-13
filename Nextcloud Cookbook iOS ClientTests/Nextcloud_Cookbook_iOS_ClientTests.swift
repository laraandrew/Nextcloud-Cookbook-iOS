//
//  Nextcloud_Cookbook_iOS_ClientTests.swift
//  Nextcloud Cookbook iOS ClientTests
//
//  Created by Vincent Meilinger on 06.09.23.
//

import XCTest
@testable import Nextcloud_Cookbook_iOS_Client

final class Nextcloud_Cookbook_iOS_ClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertISOStringToLocalStringSupportsFractionalSeconds() throws {
        let converted = Date.convertISOStringToLocalString(isoDateString: "2026-03-13T13:30:45.123Z")
        XCTAssertNotNil(converted)
    }

    func testConvertUTCStringToLocalStringParsesExpectedFormat() throws {
        let converted = Date.convertUTCStringToLocalString(utcDateString: "2026-03-13 13:30:45")
        XCTAssertNotNil(converted)
    }


    func testConvertUTCStringToLocalStringParsesPosixDate() throws {
        let utc = "2026-03-13 05:30:00"
        let result = Date.convertUTCStringToLocalString(utcDateString: utc)

        XCTAssertNotNil(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
