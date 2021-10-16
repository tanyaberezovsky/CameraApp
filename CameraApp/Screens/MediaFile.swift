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
    var name: String { get set }
}

struct PhotoFile: MediaFileProtocol {
    var image: UIImage
    var name: String
    var path: URL
    
    init(image: UIImage, name: String, path: URL){
        self.image = image
        self.name = name
        self.path = path
    }
}

struct VideoFile: MediaFileProtocol {
    var image: UIImage
    var name: String
    var path: URL
    
    init(image: UIImage, name: String, path: URL){
        self.image = image
        self.name = name
        self.path = path
    }
}
