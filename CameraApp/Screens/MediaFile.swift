//
//  MediaFile.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

protocol MediaFileProtocol {
    var image: UIImage { get set }
    var path: URL { get set }
    var fileName: String { get set }
    var imageDescription: String { get set }
}

struct PhotoFile: MediaFileProtocol {
    var image: UIImage
    var fileName: String
    var path: URL
    var imageDescription: String
    
    init(image: UIImage, fileName: String, path: URL){
        self.image = image
        self.fileName = fileName
        self.path = path
        self.imageDescription = FileNameConverter(fileName).description()
    }
}

struct VideoFile: MediaFileProtocol {
    var image: UIImage
    var fileName: String
    var path: URL
    var imageDescription: String
    
    init(image: UIImage, fileName: String, path: URL){
        self.image = image
        self.fileName = fileName
        self.path = path
        self.imageDescription = FileNameConverter(fileName).description()
    }
}
