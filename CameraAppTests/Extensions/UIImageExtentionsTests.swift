//
//  UIImageExtentionsTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 19/10/2021.
//


import XCTest
@testable import CameraApp

class UIImageExtentionsTests: XCTestCase {

    var image: UIImage!
    
    override func setUp() {
        super.setUp()        
        image = UIImage.mock()
    }
    
    override func tearDown() {
        image = nil
    }
    
    func testImageAllocated() {
        XCTAssertNotNil(image, "image does not allocated")
    }

    func testImageFullSize() {
        let imageSize = imageSize(image: image)
        XCTAssertEqual(imageSize, 159870)
    }

    func testThumbnailSize() {
        let smallimage = image.getThumbnail()!
        let imageSize = imageSize(image: smallimage)
        XCTAssertEqual(imageSize, 43129)
    }
    
    func imageSize(image: UIImage) -> Int {
        let imgSize = image.jpegData(compressionQuality: 1.0)?.count ?? 0
        print("Size of Image: \(imgSize) bytes")
        return imgSize
    }
    
}
