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
            nameLabel.text = mediaObject.imageDescription
            playImageView.isHidden = !mediaObject.isVideo()
            
            imageView.image = UIImage()
            
            let queue = DispatchQueue.global(qos: .default)
            queue.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let image = UIImage(contentsOfFile: strongSelf.mediaObject.thumbnailUrl.path) ?? UIImage()
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
                
            }
           
        }
    }

    //MARK: Public methods
    public func config(mediaObject: MediaFileProtocol) {
        self.mediaObject = mediaObject
    }
}

