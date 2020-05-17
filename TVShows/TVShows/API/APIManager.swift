//
//  APIManager.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

internal class APIManager: APIManagerProtocol {
    internal func getPopularTVShows(page: Int = 1, completion: @escaping (ResultBlock<[TVShowStruct], NetworkError>)) {
        let url = URLBuilder().popularTVShowsURL()
        let queryItems = ["page": "\(page)"]
        
        RequestBuilder().performRequest(requestType: .GET, url: url, queryItems: queryItems, body: nil) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try? decoder.decode(TVShowStructAPI.self, from: data)
                if let decoded = decoded {
                    completion(.success(decoded.results))
                } else {
                    completion(.failure(.JSONParsingError))
                }
            }
        }
    }
    
    internal func getPopularMovies(page: Int = 1, completion: @escaping (ResultBlock<[MovieStruct], NetworkError>)) {
        let url = URLBuilder().popularMoviesURL()
        let queryItems = ["page": "\(page)"]
        
        RequestBuilder().performRequest(requestType: .GET, url: url, queryItems: queryItems, body: nil) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try? decoder.decode(MoviesStructAPI.self, from: data)
                if let decoded = decoded {
                    completion(.success(decoded.results))
                } else {
                    completion(.failure(.JSONParsingError))
                }
            }
        }
    }
}
