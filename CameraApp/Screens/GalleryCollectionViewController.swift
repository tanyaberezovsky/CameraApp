//
//  GalleryCollectionViewController.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import UIKit

private let reuseIdentifier = "GalleryCell"

class GalleryCollectionViewController: UICollectionViewController {
    public var files: [MediaFileProtocol]!
    private var showPicture: String {
        return Constants.Segues.showPicture.rawValue
    }
    //TODO: delete all coments
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//    }


    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
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
        performSegue(withIdentifier: showPicture, sender: nil)
    }
}
