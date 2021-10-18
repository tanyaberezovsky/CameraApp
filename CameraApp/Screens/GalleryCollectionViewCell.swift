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
            //imageView.image = mediaObject.image
            nameLabel.text = mediaObject.imageDescription
            playImageView.isHidden = !mediaObject.isVideo()
//            if let videoFile = mediaObject as? VideoFile {
//                imageView.image = resizedImage(videoFile.urlThumbnail, for: imageView.frame.size)
//            } else {
//                imageView.image = resizedImage(mediaObject.url, for: imageView.frame.size)
//            }
        }
    }

    //MARK: Public methods
    public func config(mediaObject: MediaFileProtocol) {
        self.mediaObject = mediaObject
    }
    
    private func resizedImage(_ url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

