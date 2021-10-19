//
//  PhotoFileSaver.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import UIKit

class PhotoFileSaver {
    
    //MARK: Private variables
    private var fileSaver: FileSaverProtocol
    private var mediaDir: DirectoryManagerProtocol
    private var thumbnailDir: DirectoryManagerProtocol
    
    private var imageFilePaths: (image: URL, thumbnail: URL) {
        let fileName = timestampStr
        let image = mediaDir.filePath(fileName, Constants.FileExtention.jpg.rawValue)
        let thumbnail = thumbnailDir.filePath(fileName, Constants.FileExtention.jpg.rawValue)
        return (image, thumbnail)
    }
    
    private var timestampStr: String {
        return "\(NSDate().timeIntervalSince1970)"
    }

    //MARK: Init
    init(fileSaver: FileSaverProtocol = FileSaver(), mediaDir: DirectoryManagerProtocol = DirectoryManager(), thumbnailDir: DirectoryManagerProtocol = DirectoryManager(rootDir: Constants.thumbnailsDir)) {
        self.fileSaver = fileSaver
        self.mediaDir = mediaDir
        self.thumbnailDir = thumbnailDir
    }

    //MARK: Public method
    public func tryToSaveImage(_ info: [UIImagePickerController.InfoKey : Any]) throws {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            throw CustomErrors.fileIsEmpty
        }
        let imagefixed = image.fixOrientation()
        let imagePaths = imageFilePaths
     
        try saveImage(imagefixed, url: imagePaths.image)
      
        try saveThumbnail(imagefixed, url: imagePaths.thumbnail)
    }
    
    //MARK: Private function
    private func saveImage(_ image: UIImage, url: URL) throws {
        
        guard let _ = try? fileSaver.saveImageJPEG(image, path: url, compressionQuality: 1.0) else {
            throw CustomErrors.failedToSavePhoto
        }
    }
    
    private func saveThumbnail(_ image: UIImage, url: URL) throws {
        
        guard let thumbnail = image.getThumbnail() else {
            throw CustomErrors.failedToSaveThumbnail
        }
        
        guard let _ = try? fileSaver.saveImageJPEG(thumbnail, path: url, compressionQuality: 0.6) else {
            throw CustomErrors.failedToSavePhoto
        }
    }
 }
