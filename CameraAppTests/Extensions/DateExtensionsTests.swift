//
//  Date+ExtensionTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import XCTest
@testable import CameraApp

class DateExtensionTests: XCTestCase {

    var someDateTime: Date!
    
    override func setUp() {
        super.setUp()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        someDateTime = formatter.date(from: "2022/10/08 22:40")
    }
    
    func testDateToTimeString() {
        XCTAssertEqual(someDateTime.toString(formatter: .timeOnly), "22:40:00")
    }
}
