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

    private var imageFilePath: URL {
        return mediaDir.filePath(timestampStr, Constants.FileExtention.png.rawValue)
    }

    private var videoFilePath: (video: URL, thumbnail: URL) {
        let fileName = timestampStr
        let video = mediaDir.filePath(fileName, Constants.FileExtention.mp4.rawValue)
        let thumbnail = thumbnailDir.filePath(fileName, Constants.FileExtention.png.rawValue)
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

    //MARK: Private methods
    private func tryToSaveImage(_ info: [UIImagePickerController.InfoKey : Any]) throws {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            throw CustomErrors.fileIsEmpty
        }

        guard let _ = try? fileSaver.saveImagePNG(image.fixOrientation(), path: imageFilePath) else {
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

        tryToSaveThumbnail(videoURL, videoPaths.thumbnail) { result in
            completion(result)
        }
    }

    private func tryToSaveThumbnail(_ videoURL: URL, _ thumbnailURL: URL,
                                completion: @escaping (Result<Void, Error>) -> Void) {
        createThumbnailNew(videoURL) { [weak self] result in
            switch result {
            case .success(let image):
                guard let _ = try? self?.fileSaver.saveImagePNG(image, path: thumbnailURL) else {
                    completion(.failure(CustomErrors.failedToSaveThumbnail))
                    return
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func createThumbnailNew(_ videoURL: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        AVAsset(url: videoURL).generateThumbnail { image in
            DispatchQueue.main.async {
                if let image = image {
                    completion(.success(image))
                } else {
                    completion(.failure(CustomErrors.failedToSaveThumbnail))
                }
            }
        }
    }


}
