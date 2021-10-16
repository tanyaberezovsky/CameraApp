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

    //MARK: IBOutlets
    @IBOutlet private var cameraButton: UIButton!
    @IBOutlet private var galleryButton: UIButton!
    @IBOutlet private var photoImageView: UIImageView!
    
    //MARK: Private variables
    private var videoFilePath: URL {
        return mediaDir.filePath("video".appedTimestamp(), "mp4")
    }

    private var imageFilePath: URL {
        return mediaDir.filePath("image".appedTimestamp(), "png")
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

    private func printAllMediaFiles() {
        let fm = FileManager.default
        let dir = Constants.mediaRootDir
        let items = try! fm.contentsOfDirectory(atPath: dir.path)

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
        
        guard let _ = try? fileSaver.saveVideo(videoURL, path: videoFilePath) else {
            alert(message: "Photo not get saved.")
            return
        }
    }
}


