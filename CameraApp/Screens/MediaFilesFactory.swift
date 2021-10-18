//
//  MediaFilesFactory.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

struct MediaFilesFactory {
    
    //MARK: Private variables
    private let rootDir: URL
    private let thumbnailDir: URL
    
    //MARK: Init
    init(rootDir: URL = Constants.mediaRootDir, thumbnailDir: URL = Constants.thumbnailsDir) {
        self.rootDir = rootDir
        self.thumbnailDir = thumbnailDir
    }
    
    //MARK: Public methods
    public func create() -> [MediaFileProtocol] {
        
        let items = try! FileManager.default.contentsOfDirectory(atPath: rootDir.path).sorted { $0 > $1 }
 
        var mediaFiles = [MediaFileProtocol]()
        
        for item in items {
            mediaFiles.append(createMediaFile(item))
        }
        
        return mediaFiles
    }
    
    //MARK: Private methods
    private func createMediaFile(_ fileName: String) -> MediaFileProtocol {
        if isVideo(fileName) {
            return createVideoFile(fileName)
        } else {
            return createPhotoFile(fileName)
        }
    }
    
    private func createVideoFile(_ fileName: String) -> MediaFileProtocol {
       
        let videoFilePath = rootDir.appendingPathComponent(fileName, isDirectory: false)

        //let thumbnailVideoImage = thumbnailVideoImage(fileName)
        let thumbnailFileName = fileName.replacingOccurrences(of: Constants.FileExtention.mp4.rawValue, with: Constants.FileExtention.png.rawValue)
        
        let thumbnailFilePath = thumbnailDir.appendingPathComponent(thumbnailFileName, isDirectory: false)

        return VideoFile(image: nil, fileName: fileName, url: videoFilePath, urlThumbnail: thumbnailFilePath)
    }
    
    private func createPhotoFile(_ fileName: String) -> MediaFileProtocol {
        let filePath = rootDir.appendingPathComponent(fileName, isDirectory: false)
        //let image = getImage(filePath)

        return PhotoFile(image: nil, fileName: fileName, url: filePath)
    }
    
    private func thumbnailVideoImage(_ fileName: String) -> UIImage {
        let thumbnailFileName = fileName.replacingOccurrences(of: Constants.FileExtention.mp4.rawValue, with: Constants.FileExtention.png.rawValue)
        
        let thumbnailFilePath = thumbnailDir.appendingPathComponent(thumbnailFileName, isDirectory: false)
       
        return getImage(thumbnailFilePath)
    }
    
    
    private func getImage(_ filePath: URL) -> UIImage {
        return UIImage(contentsOfFile: filePath.path) ?? UIImage()
    }
    
    private func isVideo(_ fileName: String) -> Bool {
        if fileName.suffix(3) == Constants.FileExtention.mp4.rawValue {
            return true
        }
        return false
    }
}


