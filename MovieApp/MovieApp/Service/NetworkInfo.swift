//
//  NetworkInfo.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

struct NetworkInfo {
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3"
        static let imageBaseURL = "https://image.tmdb.org/t/p"
    }
    
    struct APIParameterKey {
        static let apiKey = "0c909c364c0bc846b72d0fe49ab71b83"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
