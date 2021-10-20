//
//  VideoFileTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import XCTest
@testable import CameraApp

class VideoFileTests: XCTestCase {

    var videoFile: MediaFileProtocol!
    
    override func setUp(){
        super.setUp()
        videoFile = VideoFile.mock()
    }

    override func tearDown() {
        videoFile = nil
        super.tearDown()
    }

    func testVideoFileResultsModelLoadsFromJSON() {
        XCTAssertNotNil(videoFile, "VideoFileResults does not allocated")
    }
    
    func testVideoFile() {
        XCTAssertEqual(videoFile.fileName, "testVideo.mp4")
        XCTAssertEqual(videoFile.url.path, URL.mockVideoUrl().path)
        XCTAssertEqual(videoFile.thumbnailUrl.path,URL.mockThumbnailUrl().path)
    }
    
}
