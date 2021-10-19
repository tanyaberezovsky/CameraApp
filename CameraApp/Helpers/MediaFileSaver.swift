//
//  MediaFileSaver.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 18/10/2021.
//

import UIKit
import MobileCoreServices

class MediaFileSaver {
    //MARK: Private variables
    private var videoFileSaver: VideoFileSaver
    private var photoFileSaver: PhotoFileSaver

    //MARK: Init
    init(fileSaver: FileSaverProtocol = FileSaver(), mediaDir: DirectoryManagerProtocol = DirectoryManager(), thumbnailDir: DirectoryManagerProtocol = DirectoryManager(rootDir: Constants.thumbnailsDir)) {
        videoFileSaver = VideoFileSaver(fileSaver: fileSaver, mediaDir: mediaDir, thumbnailDir: thumbnailDir)
        photoFileSaver = PhotoFileSaver(fileSaver: fileSaver, mediaDir: mediaDir, thumbnailDir: thumbnailDir)
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
    
    //MARK: Private method
    private func saveMediaFileOnBackground(_ info: [UIImagePickerController.InfoKey : Any],
                              completion: @escaping (Result<Void, Error>) -> Void) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString

        switch mediaType {
        case kUTTypeImage:
            do {
                try photoFileSaver.tryToSaveImage(info)
                completion(.success(()))
            } catch let error {
                completion(.failure(error))
            }
        case kUTTypeMovie:
            videoFileSaver.tryToSaveVideo(info) { result in
                completion(result)
            }
        default:
           break
        }
    }
 }


