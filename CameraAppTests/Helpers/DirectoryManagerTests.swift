//
//  DirectoryManagerTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//


import XCTest
@testable import CameraApp

class DirectoryManagerTests: XCTestCase {

    var directoryManager: DirectoryManager!
    
    override func setUp() {
        super.setUp()
        directoryManager = DirectoryManager(rootDir: Constants.mediaRootDir)
    }
    
    override func tearDown() {
        directoryManager = nil
    }
    
    func testDirectoryManagerAllocated() {
        XCTAssertNotNil(directoryManager, "DirectoryManager does not allocated")
    }

    func testMakeFilePath() {
        let url = directoryManager.makeFilePath("testfile", "jpg")
        if !url.isFileURL {
            XCTAssert(false)
        }
        let filePath = Constants.mediaRootDir.appendingPathComponent("testfile.jpg")
        print(filePath.path)
        XCTAssertEqual(url.path, filePath.path, "MakeFilePath failed to create a file path \(filePath.path)")
    }
    
    func testMakeFilePathInANewDir() {
        let testDir = Constants.mediaRootDir.appendingPathComponent("TestDir")
        directoryManager = DirectoryManager(rootDir: testDir)
  
        let url = directoryManager.makeFilePath("testfile", "jpg")
        if !url.isFileURL {
            XCTAssert(false)
        }
        let filePath = testDir.appendingPathComponent("testfile.jpg")
        print(filePath.path)
        XCTAssertEqual(url.path, filePath.path, "MakeFilePath failed to create a  file path in a new TestDir \(filePath.path)")
    }
    
    func testMakeFilePathAndTwoNewDir() {
        let testDir = Constants.mediaRootDir.appendingPathComponent("TestDir").appendingPathComponent("SecondTestDir")
        directoryManager = DirectoryManager(rootDir: testDir)
  
        let url = directoryManager.makeFilePath("testfile", "jpg")
        if !url.isFileURL {
            XCTAssert(false)
        }
        let filePath = testDir.appendingPathComponent("testfile.jpg")
        print(filePath.path)
        XCTAssertEqual(url.path, filePath.path, "MakeFilePath failed to create a  file path in a new TestDir\\SecondTestDir \(filePath.path)")
    }
}
