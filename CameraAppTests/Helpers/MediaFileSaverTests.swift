//
//  MediaMediaFileSaver.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import XCTest

@testable import CameraApp

class MediaFileSaverTests: XCTestCase {

    var mediaFileSaver: MediaFileSaver!
    var info: [UIImagePickerController.InfoKey : Any]!
    
    override func setUp() {
        super.setUp()
        mediaFileSaver = MediaFileSaver()
        info = mockImageInfoKey()
    }

    override func tearDown() {
        mediaFileSaver = nil
        info = nil
    }

    func testMediaFileSaverAllocated() {
        XCTAssertNotNil(mediaFileSaver, "MediaFileSaver does not allocated")
    }

    func testSaveMediaImage() {
         mediaFileSaver.saveMediaFile(info) { result in
            switch result {
            case .success(()):
                let items = try! FileManager.default.contentsOfDirectory(atPath: Constants.mediaRootDir.path)
                XCTAssertTrue(items.count > 0, "Error, no files was saved, directory is empty")
                let thumbnailitems = try! FileManager.default.contentsOfDirectory(atPath: Constants.thumbnailsDir.path)
                XCTAssertTrue(thumbnailitems.count > 0, "Error, no Thumbnail files was saved, directory is empty")
                
                break
            case .failure(let error):
                XCTAssert(false, "File not saved \(error.localizedDescription)")
            }
        }
    }

}

