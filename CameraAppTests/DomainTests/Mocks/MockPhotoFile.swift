//
//  MockPhotoFile.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import Foundation
@testable import CameraApp


extension PhotoFile {
    static func mock() -> PhotoFile {
        let file = PhotoFile(fileName: MockFile.testPhoto.fullName(), url: URL.mockImageUrl(), thumbnailUrl: URL.mockThumbnailUrl())
        return file
    }
    
    static func mockFail() -> PhotoFile{
        let file = PhotoFile(fileName: MockFile.testPhoto.fullName(), url: Constants.mediaRootDir, thumbnailUrl: Constants.thumbnailsDir)
        return file
    }
}
