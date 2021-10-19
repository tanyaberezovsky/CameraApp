//
//  FileSaver.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

protocol FileSaverProtocol {
    //func saveImagePNG(_ image: UIImage, path: URL) throws
    func saveImageJPEG(_ image: UIImage, path: URL, compressionQuality: CGFloat) throws
    func saveVideo(_ videoURL: URL, path: URL) throws
}

struct FileSaver {}

extension FileSaver: FileSaverProtocol {
    
//    func saveImagePNG(_ image: UIImage, path: URL ) throws {
//        guard let pngData = image.pngData() else {
//            return
//        }
//        return try saveData(pngData, path)
//    }
    
    func saveImageJPEG(_ image: UIImage, path: URL, compressionQuality: CGFloat = 1.0) throws {
        
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            return
        }
        return try saveData(data, path)
    }
    
    func saveVideo(_ videoURL: URL, path: URL) throws {
        guard let videoData = try? Data(contentsOf: videoURL) else {
            return
        }
    
        return try saveData(videoData, path)
    }
    
    private func saveData(_ pngData: Data, _ path: URL) throws {
        return try pngData.write(to: path)
    }
    
}
