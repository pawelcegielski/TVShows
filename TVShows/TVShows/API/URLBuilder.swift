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
    
    internal func popularMoviesURL() -> URL {
        let urlString = URLBuilder.baseURLString + "/movie/popular"
        return URL(string: urlString)!
    }
}
