//
//  Constants.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import Foundation

struct Constants {
    
    static public let mediaRootDir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    static public let thumbnailsDir: URL = Constants.mediaRootDir.appendingPathComponent("Thumbnail", isDirectory: true)
    
    public enum FileExtention: String {
        case mp4
        case png
    }
    
    public enum Segues: String {
        case showGallery
        case showPicture
        case showVideo
    }
}

