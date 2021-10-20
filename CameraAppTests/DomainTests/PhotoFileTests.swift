//
//  PhotoFileTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import XCTest
@testable import CameraApp

class PhotoFileTests: XCTestCase {

    var photoFile: MediaFileProtocol!
    
    override func setUp(){
        super.setUp()
        photoFile = PhotoFile.mock()
    }

    override func tearDown() {
        photoFile = nil
        super.tearDown()
    }

    func testPhotoFileResultsModelLoadsFromJSON() {
        XCTAssertNotNil(photoFile, "PhotoFileResults does not allocated")
    }
    
    func testPhotoFile() {
        XCTAssertEqual(photoFile.fileName, MockFile.testPhoto.fullName())
        XCTAssertEqual(photoFile.url.path, URL.mockImageUrl().path)
        XCTAssertEqual(photoFile.thumbnailUrl.path,URL.mockThumbnailUrl().path)
    }
    
}
