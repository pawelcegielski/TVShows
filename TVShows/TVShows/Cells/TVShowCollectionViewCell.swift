//
//  TVShowCollectionViewCell.swift
//  TVShows
//
//  Created by Pawel Cegielski on 17/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

class TVShowCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TVShowCollectionViewCell"

    @IBOutlet weak var posterImageView: UIImageView!
    
    internal var imageURLString: String?
}
