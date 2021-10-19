//
//  PhotoViewController.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 17/10/2021.
//

import UIKit

class PhotoViewController: UIViewController {

    //MARK: Public variables
    public var photoFile: MediaFileProtocol!
    
    //MARK: IBOutlets
    @IBOutlet private var imageView: UIImageView!
    
    //MARK: Controler Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    private func loadImage() {
        let queue = DispatchQueue.global(qos: .default)
        queue.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            let image = UIImage(contentsOfFile: strongSelf.photoFile.url.path) ?? UIImage()
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
            
        }
    }
}
