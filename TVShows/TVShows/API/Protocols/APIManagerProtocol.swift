//
//  APIManagerProtocol.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit
typealias ResultBlock<T, Q: Error> = (Result<T, Q>) -> ()

protocol APIManagerProtocol {
    func getPopularMovies(page: Int, completion: @escaping (ResultBlock<[MovieStruct], NetworkError>))
    func getPopularTVShows(page: Int, completion: @escaping (ResultBlock<[TVShowStruct], NetworkError>))
}
