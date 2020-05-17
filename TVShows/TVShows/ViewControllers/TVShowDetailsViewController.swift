//
//  TVShowDetailsViewController.swift
//  TVShows
//
//  Created by Pawel Cegielski on 17/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

class TVShowDetailsViewController: UIViewController {
    var tvShow: TVShowStruct?
    
    var contentView = UIView()
    var scrollView = UIScrollView()
    var showNameLabel = UILabel()
    var showPoster = UIImageView()
    var showRating = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVC()
    }
    
    func setUpVC() {
        view.backgroundColor = UIColor.systemBackground
        generateViews()
        downloadImage()
    }
    
    private func generateViews() {
        guard  let tvShow = tvShow else {
            return
        }
        showPoster.alpha = 0.0
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.distribution = .equalSpacing
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        contentView.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
        ])
        
        showNameLabel.text = tvShow.name
        showNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        showNameLabel.numberOfLines = 5
        verticalStackView.addArrangedSubview(showNameLabel)
        
        let ratingStackView = UIStackView()
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.axis = .vertical
        ratingStackView.distribution = .equalSpacing
        ratingStackView.alignment = .center
        let ratingHeader = UILabel()
        ratingHeader.text = "Rating:"
        ratingStackView.addArrangedSubview(ratingHeader)
        showRating.text = "\(tvShow.voteAverage)"
        showRating.font = UIFont.boldSystemFont(ofSize: 22)
        ratingStackView.addArrangedSubview(showRating)
        
        let votesStackView = UIStackView()
        votesStackView.translatesAutoresizingMaskIntoConstraints = false
        votesStackView.axis = .vertical
        votesStackView.distribution = .equalSpacing
        votesStackView.alignment = .center
        let votesHeader = UILabel()
        votesHeader.text = "Votes:"
        votesStackView.addArrangedSubview(votesHeader)
        let votesNumberLable = UILabel()
        votesNumberLable.text = "\(tvShow.voteCount)"
        votesNumberLable.font = UIFont.boldSystemFont(ofSize: 22)
        votesStackView.addArrangedSubview(votesNumberLable)
        
        let popularityStackView = UIStackView()
        popularityStackView.translatesAutoresizingMaskIntoConstraints = false
        popularityStackView.axis = .vertical
        popularityStackView.distribution = .equalSpacing
        popularityStackView.alignment = .center
        let popularityHeader = UILabel()
        popularityHeader.text = "Popularity:"
        popularityStackView.addArrangedSubview(popularityHeader)
        let popularityNumberLablel = UILabel()
        popularityNumberLablel.text = "\(tvShow.popularity)"
        popularityNumberLablel.font = UIFont.boldSystemFont(ofSize: 22)
        popularityStackView.addArrangedSubview(popularityNumberLablel)
        
        let imageSideStackView = UIStackView()
        imageSideStackView.translatesAutoresizingMaskIntoConstraints = false
        imageSideStackView.axis = .vertical
        imageSideStackView.distribution = .equalSpacing
        imageSideStackView.spacing = 16
        imageSideStackView.addArrangedSubview(ratingStackView)
        imageSideStackView.addArrangedSubview(votesStackView)
        imageSideStackView.addArrangedSubview(popularityStackView)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.addArrangedSubview(showPoster)
        horizontalStackView.addArrangedSubview(imageSideStackView)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        let overviewLabel = UILabel()
        overviewLabel.text = tvShow.overview
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .justified
        
        verticalStackView.addArrangedSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            showPoster.heightAnchor.constraint(equalTo: showPoster.widthAnchor, multiplier: 3/2),
        ])
    }
    
    private func downloadImage() {
        guard let tvShow = tvShow, let url = URLBuilder().getFullPosterURL(posterPath: tvShow.posterPath)
            else {return}
        APIManager().downloadData(dataURL: url) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    if let image = UIImage(data: data) {
                        self?.showPoster.image = image
                        UIView.animate(withDuration: 0.7) {
                            self?.showPoster.alpha = 1.0
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
