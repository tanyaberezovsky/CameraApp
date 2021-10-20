//
//  MokeUIImagePickerControllerInfoKey.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 20/10/2021.
//

import UIKit
import UniformTypeIdentifiers

public func mockImageInfoKey() -> [UIImagePickerController.InfoKey : Any] {
    var info = [UIImagePickerController.InfoKey : Any]()
    info[UIImagePickerController.InfoKey.mediaType] = UTType.image
    info[UIImagePickerController.InfoKey.originalImage] = UIImage.mock()
    return info
}
