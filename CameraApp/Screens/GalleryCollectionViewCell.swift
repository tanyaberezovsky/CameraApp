//
//  GalleryCollectionViewCell.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    public func config(mediaObject: MediaFileProtocol) {
        imageView.image = mediaObject.image
        nameLabel.text = mediaObject.imageDescription
    }
}

