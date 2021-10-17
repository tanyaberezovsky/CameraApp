//
//  CameraOperationsViewController+UIImagePickerControllerDelegate.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 17/10/2021.
//

import UIKit
import MobileCoreServices
import AVKit

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
        
        dismiss(animated: true, completion: nil)
    }
}

