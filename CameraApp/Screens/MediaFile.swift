//
//  MediaFile.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

protocol MediaFileProtocol {
    var image: UIImage { get set }
    var url: URL { get set }
    var fileName: String { get set }
    var imageDescription: String { get set }
    func isVideo() -> Bool
}

struct PhotoFile: MediaFileProtocol {
    var image: UIImage
    var fileName: String
    var url: URL
    var imageDescription: String
    
    init(image: UIImage, fileName: String, url: URL){
        self.image = image
        self.fileName = fileName
        self.url = url
        self.imageDescription = FileNameConverter(fileName).description()
    }

    func isVideo() -> Bool {
        return false
    }
}

struct VideoFile: MediaFileProtocol {
    var image: UIImage
    var fileName: String
    var url: URL
    var imageDescription: String
    
    init(image: UIImage, fileName: String, url: URL){
        self.image = image
        self.fileName = fileName
        self.url = url
        self.imageDescription = FileNameConverter(fileName).description()
    }
    
    func isVideo() -> Bool {
        return true
    }
}
