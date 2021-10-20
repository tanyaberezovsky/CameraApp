//
//  MediaFile.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

protocol MediaFileProtocol {
    var url: URL { get set }
    var thumbnailUrl: URL { get set }
    var fileName: String { get set }
    var imageDescription: String { get set }
    func isVideo() -> Bool
}

