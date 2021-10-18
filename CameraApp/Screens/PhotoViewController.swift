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
        imageView.image = photoFile.image
    }
}
