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
    @IBOutlet private weak var playImageView: UIImageView!
    
    private var mediaObject: MediaFileProtocol! {
        didSet {
            imageView.image = mediaObject.image
            nameLabel.text = mediaObject.imageDescription
            playImageView.isHidden = true
            if isVideo() {
                playImageView.isHidden = false
            }
        }
    }
    
    public func config(mediaObject: MediaFileProtocol) {
        self.mediaObject = mediaObject
    }
    
    private func isVideo() -> Bool {
        if mediaObject is VideoFile {
            return true
        }
        return false
    }
}

