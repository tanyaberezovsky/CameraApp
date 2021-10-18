//
//  ViewController.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 15/10/2021.
//

import UIKit
import MobileCoreServices
import AVKit

class CameraOperationsViewController: UIViewController {
    
    //MARK: Public variables
    var fileSaver: FileSaverProtocol = FileSaver()
    var mediaDir: DirectoryManagerProtocol = DirectoryManager()
    var thumbnailDir: DirectoryManagerProtocol = DirectoryManager(rootDir: Constants.thumbnailsDir)

    //MARK: IBOutlets
    @IBOutlet private var cameraButton: UIButton!
    
    //MARK: Private variables
    private var segueShowGallery: String {
        return Constants.Segues.showGallery.rawValue
    }
    
    private var timestampStr: String {
        return "\(NSDate().timeIntervalSince1970)"
    }
    
    private var imageFilePath: URL {
        return mediaDir.filePath(timestampStr, Constants.FileExtention.png.rawValue)
    }
    
    private var videoFilePath: (video: URL, thumbnail: URL) {
        let fileName = timestampStr
        let video = mediaDir.filePath(fileName, Constants.FileExtention.mp4.rawValue)
        let thumbnail = thumbnailDir.filePath(fileName, Constants.FileExtention.png.rawValue)
        return (video, thumbnail)
    }

    

    //MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    //MARK: Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueShowGallery {
           if let viewController = segue.destination as? GalleryCollectionViewController {
               viewController.files = MediaFilesFactory(rootDir: Constants.mediaRootDir, thumbnailDir: Constants.thumbnailsDir).create()
           }
       }
    }
    
    //MARK: - Actions
    @IBAction func openCamera() {
        tryOpenCamera()
    }
    @IBAction func openGallery() {
        performSegue(withIdentifier: segueShowGallery, sender: self)
    }
    @IBAction func unwindToGallery(segue: UIStoryboardSegue){
    }
    
    //MARK: - Private functions
    private func setupNavBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.systemBlue
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }
    
    private func tryOpenCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
        else {
            alert(message: "Device has no camera.")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
        picker.delegate = self
        present(picker, animated: true)
    }
  
    func printAllMediaFiles(_ dir: URL = Constants.mediaRootDir) {
        let items = try! FileManager.default.contentsOfDirectory(atPath: dir.path)

        for item in items {
            print(item)
        }
    }
    func tryToSaveImage(_ info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            alert(message: "Can not save photo.")
            return
        }

        guard let _ = try? fileSaver.saveImagePNG(image.fixOrientation(), path: imageFilePath) else {
            alert(message: "Photo not get saved.")
            return
        }
    }
    
    func tryToSaveVideo(_ info: [UIImagePickerController.InfoKey : Any]) {

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

extension CameraOperationsViewController: UINavigationControllerDelegate {}

