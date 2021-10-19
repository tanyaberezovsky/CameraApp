//
//  GalleryCollectionViewCell.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

var globalImagesCache: NSCache<NSString, UIImage> = NSCache()

class GalleryCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var playImageView: UIImageView!
    
    //MARK: Private variables
    var imageLoader: ImageCacheLoader!
    
    private var mediaObject: MediaFileProtocol! {
        didSet {
            nameLabel.text = mediaObject.imageDescription
            playImageView.isHidden = !mediaObject.isVideo()
            
            imageView.image = UIImage()
            
            imageLoader = ImageCacheLoader(imagePath: mediaObject.thumbnailUrl.path, cache: globalImagesCache)
            imageLoader.obtainImageWithPath(imagePath: mediaObject.thumbnailUrl.path) { [weak self] image in
                self?.imageView.image = image
            }
        }
    }

    //MARK: Public methods
    public func config(mediaObject: MediaFileProtocol) {
        self.mediaObject = mediaObject
    }
}

