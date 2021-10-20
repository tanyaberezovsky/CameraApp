//
//  PhotoFileSaverTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//


import XCTest

@testable import CameraApp

class PhotoFileSaverTests: XCTestCase {

    var photoFileSaver: PhotoFileSaver!
    var info: [UIImagePickerController.InfoKey : Any]!
    
    override func setUp() {
        super.setUp()
        photoFileSaver = PhotoFileSaver()
        info = mockImageInfoKey()
    }

    override func tearDown() {
        photoFileSaver = nil
        info = nil
    }

    func testPhotoFileSaverAllocated() {
        XCTAssertNotNil(photoFileSaver, "PhotoFileSaver does not allocated")
    }

    func testSavePhotoImage() {
        do {
            try photoFileSaver.tryToSaveImage(info)
            
            let items = try! FileManager.default.contentsOfDirectory(atPath: Constants.mediaRootDir.path)
            XCTAssertTrue(items.count > 0, "Error, no files was saved, directory is empty")
            
            let thumbnailitems = try! FileManager.default.contentsOfDirectory(atPath: Constants.thumbnailsDir.path)
            XCTAssertTrue(thumbnailitems.count > 0, "Error, no Thumbnail files was saved, directory is empty")
        
        } catch let error {
            XCTAssertTrue(true, error.localizedDescription)
        }
        
    }

}

