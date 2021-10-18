//
//  PhotoViewController.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 17/10/2021.
//

import UIKit

class PhotoViewController: UIViewController {

    var photoFile: MediaFileProtocol!
    
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = photoFile.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
