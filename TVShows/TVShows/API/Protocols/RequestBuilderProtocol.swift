//
//  RequestBuilderProtocol.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit
typealias APIResult = ((Result<Data, NetworkError>)->())

protocol RequestBuilderProtocol {
    func performRequest(requestType: NetworkRequestType, url: URL,  queryItems: [String : String]?, body: [String:Any]?, completionHandler: @escaping (APIResult))
}
