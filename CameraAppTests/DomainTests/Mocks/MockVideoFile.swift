//
//  MockVideoFile.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import Foundation
@testable import CameraApp


extension VideoFile {
    static func mock() -> VideoFile{
        let file = VideoFile(fileName: MockFile.testVideo.fullName(), url: URL.mockVideoUrl(), thumbnailUrl: URL.mockThumbnailUrl())
        return file
    }
    
    static func mockFail() -> VideoFile{
        let file = VideoFile(fileName: MockFile.testVideo.fullName(), url: Constants.mediaRootDir, thumbnailUrl: Constants.thumbnailsDir)
        return file
    }
}
