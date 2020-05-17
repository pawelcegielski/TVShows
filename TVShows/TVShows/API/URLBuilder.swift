//
//  URLBuilder.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

internal class URLBuilder: URLBuilderProtocol {
    private static let baseURLString = "https://api.themoviedb.org/3"
    private static let imageBaseURLString = "https://image.tmdb.org/t/p"
    
    internal func getThumbnailPosterURL(posterPath: String) -> URL? {
        let urlString = URLBuilder.imageBaseURLString + "/w342" + posterPath
        return URL(string: urlString)
    }
    
    func getFullPosterURL(posterPath: String) -> URL? {
        let urlString = URLBuilder.imageBaseURLString + "/original" + posterPath
        return URL(string: urlString)
    }
    
    internal func popularTVShowsURL() -> URL {
        let urlString = URLBuilder.baseURLString + "/tv/popular"
        return URL(string: urlString)!
    }
    
    internal func popularMoviesURL() -> URL {
        let urlString = URLBuilder.baseURLString + "/movie/popular"
        return URL(string: urlString)!
    }
}
