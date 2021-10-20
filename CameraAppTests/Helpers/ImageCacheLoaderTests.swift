//
//  ImageCacheLoaderTests.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import XCTest
@testable import CameraApp

class ImageCacheLoaderTests: XCTestCase {

    var imageCacheLoader: ImageCacheLoader!
    var cache: NSCache<NSString, UIImage>!
    
    override func setUp() {
        super.setUp()
        cache = NSCache()
        imageCacheLoader = ImageCacheLoader(imagePath: URL.mockImageUrl().path, cache: cache)
    }
    
    override func tearDown() {
        cache = nil
        imageCacheLoader = nil
    }
    
    func testImageCacheLoaderAllocated() {
        XCTAssertNotNil(imageCacheLoader, "ImageCacheLoader does not allocated")
        XCTAssertNotNil(cache, "cache does not allocated")
    }

    func testLoadImage() {
        imageCacheLoader.obtainImageWithPath(imagePath: URL.mockImageUrl().path) { image in
            XCTAssertNil(image, "imageCacheLoader failed to load image")
        }
    }
    
    func testCacheImage() {
        let cacheimage: UIImage? = cache.object(forKey: URL.mockImageUrl().path as NSString)
        XCTAssertNil(cacheimage, "failed to load image into cache object")
   
    }

}
