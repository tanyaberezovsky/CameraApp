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
    
    //MARK: IBOutlets
    @IBOutlet private var cameraButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    //MARK: Private variables
    private lazy var mediaSaver: MediaFileSaver = {
       return MediaFileSaver()
    }()
    
    private var imagePickerDelegate: ImagePickerControllerDelegate?

    //MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Actions
    @IBAction func openCamera() {
        tryOpenCamera()
    }
           
    //MARK: - Private functions
    private func setupUI() {
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
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
      
        imagePickerDelegate = ImagePickerControllerDelegate()
        imagePickerDelegate?.mediaControllerDelegate = self
        imagePickerController.delegate = imagePickerDelegate
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension CameraOperationsViewController: MediaFileUpdatable {
    func saveMediaFile(_ info: [UIImagePickerController.InfoKey : Any]) {
        activityIndicator.startAnimating()
    
             mediaSaver.saveMediaFile(info) { [weak self] result in
                 self?.activityIndicator.stopAnimating()
             
                switch result {
                case .failure(let error):
                    self?.alert(message: error.localizedDescription)
                case .success(_):
                    break
                }
            }
    }
}

