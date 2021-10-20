//
//  MockURL.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import Foundation

@testable import CameraApp

enum MockFile: String {
    case testPhoto
    case testVideo
    func fullName() -> String {
        switch self {
        case .testPhoto:
            return "\(self.rawValue).jpg"
        case .testVideo:
            return "\(self.rawValue).mp4"
        }
    }
}

extension URL {
    public static func mockImageUrl() -> URL {
  
        let fileName = MockFile.testPhoto.rawValue
        let fileType = Constants.FileExtention.jpg.rawValue
        
        class BundleClass {}

        let bundle = Bundle(for: BundleClass.self)

        guard let filePath = bundle.path(forResource: fileName, ofType: fileType) else {
            fatalError("file not found \(MockFile.testPhoto.fullName())")
        }
        
        return URL(fileURLWithPath: filePath)
    }
    
    public static func mockThumbnailUrl() -> URL {
  
        let fileName = MockFile.testPhoto.rawValue
        let fileType = Constants.FileExtention.jpg.rawValue
        
        class BundleClass {}

        let bundle = Bundle(for: BundleClass.self)

        guard let filePath = bundle.path(forResource: fileName, ofType: fileType) else {
            fatalError("file not found \(MockFile.testPhoto.fullName())")
        }
        
        return URL(fileURLWithPath: filePath)
    }
    
    public static func mockVideoUrl() -> URL {
  
        let fileName = MockFile.testVideo.rawValue
        let fileType = Constants.FileExtention.mp4.rawValue
        
        class BundleClass {}

        let bundle = Bundle(for: BundleClass.self)

        guard let filePath = bundle.path(forResource: fileName, ofType: fileType) else {
            fatalError("file not found  \(MockFile.testVideo.fullName())")
        }
        
        return URL(fileURLWithPath: filePath)
    }
}
