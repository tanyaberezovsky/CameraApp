//
//  MediaFilesFactory.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import XCTest
@testable import CameraApp

class MediaFilesFactoryTests: XCTestCase {

    var mediaFilesFactory: MediaFilesFactory!
    
    override func setUp() {
        super.setUp()
        mediaFilesFactory = MediaFilesFactory()
        let fileSaver = FileSaver()
        
        var filePath = Constants.mediaRootDir.appendingPathComponent("test.jpg")

        try? fileSaver.saveImageJPEG(UIImage.mock(), path: filePath)
        
        
        filePath = Constants.thumbnailsDir.appendingPathComponent("test.jpg")

        try? fileSaver.saveImageJPEG(UIImage.mock(), path: filePath)
        
    }
    
    override func tearDown() {
        mediaFilesFactory = nil
    }
    
    func testMediaFilesFactoryAllocated() {
        XCTAssertNotNil(mediaFilesFactory, "MediaFilesFactory does not allocated")
    }

    func testMediaFilesFactoryCreate() {
        let arrOfMediaFiles = mediaFilesFactory.create()
        XCTAssertTrue(arrOfMediaFiles.count > 0, "Error. Media Files array must contain at least 1 file, test.jpg")
    }
    
}
