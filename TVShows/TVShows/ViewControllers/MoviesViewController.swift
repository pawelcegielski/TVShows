//
//  FirstViewController.swift
//  TVShows
//
//  Created by Pawel Cegielski on 13/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet internal weak var tableView: UITableView!
    
    private var movies = [MovieStruct]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        APIManager().getPopularMovies { (moviesResult) in
            if case .success(let movies) = moviesResult {
                DispatchQueue.main.async {
                    self.movies = movies
                }
            }
        }
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? MovieTableViewCell {
            let movie = movies[indexPath.row]
            cell.movieNameLabel.text = movie.title
            cell.ratingLabel.text = "\(movie.voteAverage)"
            cell.voteCountLabel.text = "\(movie.voteCount)"
        }
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
