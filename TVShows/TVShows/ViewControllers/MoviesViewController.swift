//
//  FirstViewController.swift
//  TVShows
//
//  Created by Pawel Cegielski on 13/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager().getPopularMovies { (movies) in
            print(movies)
        }
    }
}

