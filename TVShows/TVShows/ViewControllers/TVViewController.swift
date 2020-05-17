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
    
    private func handleImage(cell: TVShowCollectionViewCell, imageURL: URL, indexPath: IndexPath ) {
        if let image = imageCache.object(forKey: NSString(string: imageURL.absoluteString)) {
            cell.posterImageView.image = image
        } else {
            downloadImage(imageURL: imageURL) { (result) in
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
    
    private func downloadImage(imageURL: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: imageURL) {(data, reponse, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.requestError))
            }
        }
        dataTask.resume()
    }
}

extension TVViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10))/2
        return CGSize(width: size, height: size*3/2)
    }
    
}
