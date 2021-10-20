//
//  FileSaver.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//


import XCTest
@testable import CameraApp

class FileSaverTests: XCTestCase {

    var fileSaver: FileSaver!
    
    override func setUp() {
        super.setUp()
        fileSaver = FileSaver()
    }
    
    override func tearDown() {
        fileSaver = nil
    }
    
    func testFileSaverAllocated() {
        XCTAssertNotNil(fileSaver, "FileSaver does not allocated")
    }

    func testSaveImageJPEG() {
        let filePath = Constants.mediaRootDir.appendingPathComponent("test.jpg")

        XCTAssertNoThrow(try fileSaver.saveImageJPEG(UIImage.mock(), path: filePath), "can not save UIImage.mock as test.jpg")

        XCTAssert(isFileExist(url: filePath), "File is not saved \(filePath)")
    }
    
    private func isFileExist(url: URL) -> Bool {
        let filePath = url.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            return true
        } else {
            return false
        }
    }
}
