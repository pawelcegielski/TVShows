//
//  URLBuilderProtocol.swift
//  TVShows
//
//  Created by Pawel Cegielski on 15/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

protocol URLBuilderProtocol {
    func popularMoviesURL() -> URL
    func popularTVShowsURL() -> URL
    func getThumbnailPosterURL(posterPath: String) -> URL?
    func getFullPosterURL(posterPath: String) -> URL?
}
