//
//  PhotoFile.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import UIKit

struct PhotoFile: MediaFileProtocol {
    
    var fileName: String
    var url: URL
    var thumbnailUrl: URL
    var imageDescription: String
    
    init(fileName: String, url: URL, thumbnailUrl: URL){
        self.fileName = fileName
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.imageDescription = FileNameConverter(fileName).description()
    }

    func isVideo() -> Bool {
        return false
    }
}
