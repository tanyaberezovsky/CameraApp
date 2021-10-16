//
//  ViewController.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 15/10/2021.
//

import UIKit
import MobileCoreServices
//import UniformTypeIdentifiers replace kUTTypeImage with UTType.image
import AVKit


class CameraOperationsViewController: UIViewController {
    //MARK: Public variables
    var fileSaver: FileSaverProtocol = FileSaver()
    var mediaDir: DirectoryManagerProtocol = DirectoryManager()
    var thumbnailDir: DirectoryManagerProtocol = DirectoryManager(rootDir: Constants.thumbnailsDir)

    //MARK: IBOutlets
    @IBOutlet private var cameraButton: UIButton!
    @IBOutlet private var galleryButton: UIButton!
    @IBOutlet private var photoImageView: UIImageView!
    
    //MARK: Private variables
    private var imageFilePath: URL {
        return mediaDir.filePath("camapp".appedTimestamp(), "png")
    }
    
    private var videoFilePath: (video: URL, thumbnail: URL) {
        let fileName = "camapp".appedTimestamp()
        let video = mediaDir.filePath(fileName, "mp4")
        let thumbnail = thumbnailDir.filePath(fileName, "png")
        return (video, thumbnail)
    }

    

    //MARK: - Controller lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //takePhotoVideo()
//
//    }
    
    //MARK: - Actions
    @IBAction func openCamera() {
        tryOpenCamera()
    }
    @IBAction func openGallery() {
        tryOpenGallery()
    }
    //MARK: - Private functions
    private func tryOpenCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
        else {
            alert(message: "Device has no camera.")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func tryOpenGallery() {
//        self.imagePickerController.sourceType = .photoLibrary
//        self.present(self.imagePickerController, animated: true, completion: nil)
    }

    private func printAllMediaFiles(_ dir: URL = Constants.mediaRootDir) {
        let items = try! FileManager.default.contentsOfDirectory(atPath: dir.path)

        for item in items {
            print(item)
        }
    }
}

extension CameraOperationsViewController: UINavigationControllerDelegate {}

extension CameraOperationsViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard info[UIImagePickerController.InfoKey.mediaType] != nil else {
            alert(message: "Something went wrong. Please try latter.")
            return
        }
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString

        dismiss(animated: true, completion: nil)
        
        switch mediaType {
        case kUTTypeImage:
            tryToSaveImage(info)
            break
        case kUTTypeMovie:
            tryToSaveVideo(info)
            break
        default:
            break
        }
        
        printAllMediaFiles()
        printAllMediaFiles(Constants.thumbnailsDir)
    }
    
    private func tryToSaveImage(_ info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            alert(message: "Can not save photo.")
            return
        }

        guard let _ = try? fileSaver.saveImagePNG(image, path: imageFilePath) else {
            alert(message: "Photo not get saved.")
            return
        }
    }
    
    private func tryToSaveVideo(_ info: [UIImagePickerController.InfoKey : Any]) {

        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
            alert(message: "Can not save video.")
            return
        }
        
        let videoPaths = videoFilePath
        guard let _ = try? fileSaver.saveVideo(videoURL, path: videoPaths.video) else {
            alert(message: "Video not get saved.")
            return
        }
        
        createThumbnail(videoURL) { [weak self] (image) in
            guard let image = image else { return }
            guard let _ = try? self?.fileSaver.saveImagePNG(image, path: videoPaths.thumbnail) else {
                self?.alert(message: "Thumbnail not get saved.")
                return
            }
        }
    }
    
    private func createThumbnail(_ videoURL: URL, completion: @escaping (UIImage?) -> Void) {
        AVAsset(url: videoURL).generateThumbnail { image in
            DispatchQueue.main.async {
                 completion(image)
            }
        }
    }
}


