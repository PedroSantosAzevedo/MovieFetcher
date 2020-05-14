//
//  MovieEndpoint.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Alamofire

/**
 
 - Returns: The request for a determinated operation
 */
enum MovieEndpoint: APIConfiguration {
    /**
     Get the popular movies
     
     - Parameters:
     - page: The request page
     */
    case popular(page: Int)
    case genreList
    case search(movie:String)
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .popular,.genreList,.search:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .popular(let page):
            return "/movie/popular?api_key=\(NetworkInfo.APIParameterKey.apiKey)&page=\(page)"
        case .genreList:
            return "/genre/movie/list?api_key=\(NetworkInfo.APIParameterKey.apiKey)"
        case .search(let movie):
            return "/search/movie?api_key=\(NetworkInfo.APIParameterKey.apiKey)&query="+movie
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .popular,.genreList,.search:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = NetworkInfo.ProductionServer.baseURL + path
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
