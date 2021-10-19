//
//  GalleryCollectionViewController.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit
import AVKit

private let reuseIdentifier = "GalleryCell"

class GalleryCollectionViewController: UICollectionViewController {
    
    //MARK: Public variables
    public lazy var files: [MediaFileProtocol] = {
      return MediaFilesFactory(rootDir: Constants.mediaRootDir, thumbnailDir: Constants.thumbnailsDir).create()
    }()
   
    //MARK: IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    //MARK: Private variables
    private var showPicture: String {
        return Constants.Segues.showPicture.rawValue
    }

    //MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Action
    @IBAction func unwindToGallery(segue: UIStoryboardSegue){
    }
    
    //MARK: - Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showPicture {
            
            guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
            
            let destinationController = segue.destination as! PhotoViewController
            destinationController.photoFile = files[indexPaths[0].row]
            collectionView.deselectItem(at: indexPaths[0], animated: false)
         }
    }
    
    //MARK: - CollectionView methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
    
        cell.config(mediaObject: files[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if files[indexPath.row].isVideo() {
            playVideo(url: files[indexPath.row].url)
        } else {
            performSegue(withIdentifier: showPicture, sender: nil)
        }
    }
    
    //MARK: Private methods
    private func setupUI() {
//        activityIndicator.style = .large
//        activityIndicator.color = .white
        //activityIndicator.hidesWhenStopped = true
    }
    
    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        self.present(vcPlayer, animated: true, completion: nil)
    }
}
