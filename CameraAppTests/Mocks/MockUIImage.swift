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
        
        return UIImage(contentsOfFile: URL.mockImageUrl().path) ?? UIImage()
    }
}
