//
//  GalleryCollectionViewCell.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var playImageView: UIImageView!
    
    //MARK: Private variables
    private var mediaObject: MediaFileProtocol! {
        didSet {
            imageView.image = mediaObject.image
            nameLabel.text = mediaObject.imageDescription
            playImageView.isHidden = !mediaObject.isVideo()
        }
    }

    //MARK: Public methods
    public func config(mediaObject: MediaFileProtocol) {
        self.mediaObject = mediaObject
    }
}

