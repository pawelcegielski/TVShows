//
//  Movies.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

internal struct MovieStruct: Codable {
    var title: String
    var id: Int
    var posterPath: String
    var voteAverage: Double
    var popularity: Double
    var voteCount: Int
}

internal struct MoviesStructAPI: Codable {
    var page: Int
    var results: [MovieStruct]
    var totalResults: Int
    var totalPages: Int
}
