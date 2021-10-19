//
//  MockUIImage.swift
//  CameraAppTests
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import UIKit

@testable import CameraApp

extension UIImage {
    public static func mock() -> UIImage {
  
        let fileName = "swift-og"
        let fileType = "jpg"
        
        class BundleClass {}

        let bundle = Bundle(for: BundleClass.self)

        guard let filePath = bundle.path(forResource: fileName, ofType: fileType) else {
            fatalError("file not found swift-og.png")
        }
        
        return UIImage(contentsOfFile: filePath) ?? UIImage()
    }
}
