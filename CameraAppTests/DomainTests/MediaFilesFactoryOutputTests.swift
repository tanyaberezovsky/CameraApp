//
//  MediaFilesArray.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import XCTest
@testable import CameraApp

class MediaFilesArrayTests: XCTestCase {

    
    var arrOfMediaFiles: [MediaFileProtocol]!
    
    override func setUp() {
        super.setUp()
        
        let mediaFilesFactory = MediaFilesFactory()
        let fileSaver = FileSaver()
        
        var filePath = Constants.mediaRootDir.appendingPathComponent("test.jpg")

        try? fileSaver.saveImageJPEG(UIImage.mock(), path: filePath)
        
        
        filePath = Constants.thumbnailsDir.appendingPathComponent("test.jpg")

        try? fileSaver.saveImageJPEG(UIImage.mock(), path: filePath)
        
        arrOfMediaFiles = mediaFilesFactory.create()
  
    }
    
    override func tearDown() {
        arrOfMediaFiles = nil
    }
    
    func testArrOfMediaFilesAllocated() {
        XCTAssertNotNil(arrOfMediaFiles, "Array Of MediaFiles does not allocated")
    }

    func testPhotoMediaFile() {
        arrOfMediaFiles.forEach { file in
            if file.fileName == "test.jpg" {
                XCTAssertTrue(isFileExist(url: file.url), "test.jpg is not exist in root dir")
                XCTAssertTrue(isFileExist(url: file.thumbnailUrl), "test.jpg thumbnail is not exist")
            }
        }
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

