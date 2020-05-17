//
//  SecondViewController.swift
//  TVShows
//
//  Created by Pawel Cegielski on 13/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

class TVViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var imageCache = NSCache<NSString, UIImage>()
    private var tvShows = [TVShowStruct]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "TV Shows"
        APIManager().getPopularTVShows { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                DispatchQueue.main.async {
                    self.tvShows = success
                }
            }
        }
    }
}

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? TVShowCollectionViewCell {
            let tvShow = tvShows[indexPath.row]
            cell.posterImageView.image = nil
            if let imageURL = URLBuilder().getThumbnailPosterURL(posterPath: tvShow.posterPath) {
                cell.imageURLString = imageURL.absoluteString
                handleImage(cell: cell, imageURL: imageURL, indexPath: indexPath)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvShow = tvShows[indexPath.row]
        
        let vc = TVShowDetailsViewController()
        vc.tvShow = tvShow
        navigationController?.pushViewController(vc, animated: true)
    }
    private func handleImage(cell: TVShowCollectionViewCell, imageURL: URL, indexPath: IndexPath ) {
        if let image = imageCache.object(forKey: NSString(string: imageURL.absoluteString)) {
            cell.posterImageView.image = image
        } else {
            APIManager().downloadData(dataURL: imageURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    DispatchQueue.main.async { [weak self] in
                        if let image = UIImage(data: data) {
                            if cell.imageURLString == imageURL.absoluteString {
                                cell.posterImageView.image = image
                            }
                            self?.imageCache.setObject(image, forKey: NSString(string: imageURL.absoluteString))
                        }
                    }
                }
            }
        }
    }
}

extension TVViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10))/2
        return CGSize(width: size, height: size*3/2)
    }
    
}
