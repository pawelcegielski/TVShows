//
//  TVShowStruct.swift
//  TVShows
//
//  Created by Pawel Cegielski on 17/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

internal struct TVShowStruct: Codable {
    var name: String
    var id: Int
    var posterPath: String
    var voteAverage: Double
    var popularity: Double
    var voteCount: Int
    var overview: String
}

internal struct TVShowStructAPI: Codable {
    var page: Int
    var results: [TVShowStruct]
    var totalResults: Int
    var totalPages: Int
}
