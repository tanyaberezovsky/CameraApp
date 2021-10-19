//
//  MediaFileSaver.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 18/10/2021.
//

import UIKit
import MobileCoreServices
import AVKit

class MediaFileSaver {
    
    //MARK: Private variables
    private var fileSaver: FileSaverProtocol
    private var mediaDir: DirectoryManagerProtocol
    private var thumbnailDir: DirectoryManagerProtocol

    private var imageFilePath: (image: URL, thumbnail: URL) {
        let fileName = timestampStr
        let image = mediaDir.filePath(fileName, Constants.FileExtention.jpg.rawValue)
        let thumbnail = thumbnailDir.filePath(fileName, Constants.FileExtention.jpg.rawValue)
        return (image, thumbnail)
    }
    
    private var videoFilePath: (video: URL, thumbnail: URL) {
        let fileName = timestampStr
        let video = mediaDir.filePath(fileName, Constants.FileExtention.mp4.rawValue)
        let thumbnail = thumbnailDir.filePath(fileName, Constants.FileExtention.jpg.rawValue)
        return (video, thumbnail)
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
    public func saveMediaFile(_ info: [UIImagePickerController.InfoKey : Any],
                              completion: @escaping (Result<Void, Error>) -> Void) {
        
        DispatchQueue.global().async {
        
            self.saveMediaFileOnBackground(info) { result in
                DispatchQueue.main.async {
                  completion(result)
                }
            }
        }

    }
    
    //MARK: Private methods
    private func saveMediaFileOnBackground(_ info: [UIImagePickerController.InfoKey : Any],
                              completion: @escaping (Result<Void, Error>) -> Void) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString

        switch mediaType {
        case kUTTypeImage:
            do {
                try tryToSaveImage(info)
                completion(.success(()))
            } catch let error {
                completion(.failure(error))
            }
        case kUTTypeMovie:
            tryToSaveVideo(info) { result in
                completion(result)
            }
        default:
           break
        }
    }

    private func tryToSaveImage(_ info: [UIImagePickerController.InfoKey : Any]) throws {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            throw CustomErrors.fileIsEmpty
        }
        
        let imagefixed = image.fixOrientation()
        let imagePaths = imageFilePath
        
        guard let _ = try? fileSaver.saveImageJPEG(imagefixed, path: imagePaths.image, compressionQuality: 1.0) else {
            throw CustomErrors.failedToSavePhoto
        }
      
        guard let thumbnail = imagefixed.getThumbnail() else {
            throw CustomErrors.failedToSaveThumbnail
        }
        
        guard let _ = try? fileSaver.saveImageJPEG(thumbnail, path: imagePaths.thumbnail, compressionQuality: 0.6) else {
            throw CustomErrors.failedToSavePhoto
        }
    }

    private func tryToSaveVideo(_ info: [UIImagePickerController.InfoKey : Any],
                                completion: @escaping (Result<Void, Error>) -> Void) {

        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
            completion(.failure(CustomErrors.fileIsEmpty))
            return
        }

        let videoPaths = videoFilePath
        guard let _ = try? fileSaver.saveVideo(videoURL, path: videoPaths.video) else {
            completion(.failure(CustomErrors.failedToSaveVideo))
            return
        }

        tryToCreateThumbnailFromVideo(videoURL) { [weak self] result in
            switch result {
            case .success(let thumbnail):
             
                guard let _ = try? self?.fileSaver.saveImageJPEG(thumbnail, path: videoPaths.thumbnail, compressionQuality: 0.6) else {
                    completion(.failure(CustomErrors.failedToSaveThumbnail))
                    return
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    private func tryToCreateThumbnailFromVideo(_ videoURL: URL,
                                completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        createRawThumbnailFromVideo(videoURL) { result in
            switch result {
                
            case .success(let image):
             
                guard let thumbnail = image.getThumbnail() else {
                    completion(.failure(CustomErrors.failedToSaveThumbnail))
                    return
                }
         
                completion(.success(thumbnail))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func createRawThumbnailFromVideo(_ videoURL: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let asset = AVAsset(url: videoURL)
        
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        assetImgGenerate.generateCGImagesAsynchronously(forTimes: [CMTime(value: 1, timescale: 2) as NSValue]) { _, cgimage, _, _, _ in
            
            if let cgimage = cgimage {
                let image =  UIImage(cgImage: cgimage)
            
                completion(.success(image))
            } else {
                
                completion(.failure(CustomErrors.failedToSaveThumbnail))
            }
          }
    }
 }
