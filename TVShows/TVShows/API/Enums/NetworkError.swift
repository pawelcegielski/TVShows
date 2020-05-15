//
//  Error.swift
//  TVShows
//
//  Created by Pawel Cegielski on 14/05/2020.
//  Copyright © 2020 Pawel Cegielski. All rights reserved.
//

import UIKit

internal enum NetworkError: Error {
    case badURL
    case requestError
    case responseError
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalSerwerError
    case badGateway
    case otherHTTPCodeError
    case JSONParsingError
}
