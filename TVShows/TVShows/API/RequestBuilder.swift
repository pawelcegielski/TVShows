//
//  RequestBuilder.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

internal class RequestBuilder: RequestBuilderProtocol {
    private let session = URLSession.shared
    
    internal func performRequest(requestType: NetworkRequestType, url: URL, queryItems: [String : String]?, body: [String : Any]?, completionHandler: @escaping (ResultBlock<Data, NetworkError>)) {
        
        let request = createRequest(url: url, body: body, queryItems: queryItems, requestType: requestType)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure(.requestError))
            }
            guard let response = response as? HTTPURLResponse else { completionHandler(.failure(.responseError)); return}
            switch response.statusCode {
                case 200, 201, 202, 204:
                    break
                case 400:
                    completionHandler(.failure(.badRequest))
                case 401:
                    completionHandler(.failure(.unauthorized))
                case 403:
                    completionHandler(.failure(.forbidden))
                case 404:
                    completionHandler(.failure(.notFound))
                case 500:
                    completionHandler(.failure(.internalSerwerError))
                case 502:
                    completionHandler(.failure(.badGateway))
                default:
                    completionHandler(.failure(.otherHTTPCodeError))
            }
            
            if let data = data {
                completionHandler(.success(data))
            }
        }
        dataTask.resume()
    }
    
    
    private func createRequest(url: URL, body: [String: Any]?, queryItems: [String : String]?, requestType: NetworkRequestType) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = requestType.rawValue
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if let queryItems = queryItems {
            components?.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1)}
            request.url = components?.url
        }
        
        if requestType != .GET {
            if let body = body {
                if let json = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
                    request.httpBody = json
                }
            }
        }
        return request
    }
}
