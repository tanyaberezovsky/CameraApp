//
//  FileNameConverterTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import XCTest
@testable import CameraApp

class FileNameConverterTests: XCTestCase {

    var converter: FileNameConverter!
    var timestampStr: String {
        return "1634672185.892898"
    }
    
    override func setUp() {
        super.setUp()
        print(timestampStr)
        converter = FileNameConverter("\(timestampStr).jpg")
    }
    
    override func tearDown() {
        converter = nil
    }
    
    func testConverterAllocated() {
        XCTAssertNotNil(converter, "converter does not allocated")
    }

    func testdescription() {
        XCTAssertEqual(converter.description(), "22:36:25")
    }

}

