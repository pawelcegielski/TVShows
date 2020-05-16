//
//  MovieTableViewCell.swift
//  TVShows
//
//  Created by Pawel Cegielski on 16/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "movieTableViewCell"
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
