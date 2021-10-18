//
//  ImagePickerControllerDelegate.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 18/10/2021.
//

import UIKit

protocol MediaFileUpdatable: AnyObject {
    func saveMediaFile(_ info: [UIImagePickerController.InfoKey : Any])
}

class ImagePickerControllerDelegate: NSObject {
    weak var mediaControllerDelegate: MediaFileUpdatable?
}

extension ImagePickerControllerDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            picker.dismiss(animated: true) {
                self.mediaControllerDelegate?.saveMediaFile(info)
            }
        }

        guard info[UIImagePickerController.InfoKey.mediaType] != nil else {
           fatalError("Expected a dictionary containing a media data, but was provided the following: \(info)")
        }
    }
}
