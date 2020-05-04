//
//  MovieClient.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Alamofire

class MovieClient {
    @discardableResult
    private static func performRequest(route: MovieEndpoint, completion: @escaping (DataResponse<Any, AFError>?) -> Void) -> DataRequest {
        return AF.request(route).validate().responseJSON { (response: DataResponse<Any, AFError>?) in
            
            completion(response)
        }
    }
    
    static func getPopular(page: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        performRequest(route: .popular(page: page)) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    
                    guard let jsonData = utf8Text.data(using: .utf8) else {
                        completion(nil, response?.error)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedJson = try decoder.decode(MDBResponse.self, from: jsonData)
                        dump(decodedJson)
                        
                        completion(decodedJson.results, nil)
                    } catch {
                        
                        
                    }
                }
            } else {
                completion(nil,response?.error)
            }
        }
    }
    
    
    static func getGenreList(completion: @escaping ([Genre]?, Error?) -> Void) {
        performRequest(route: .genreList) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    
                    guard let jsonData = utf8Text.data(using: .utf8) else {
                        completion(nil, response?.error)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedJson = try decoder.decode(GenreListResponse.self, from: jsonData)
                        dump(decodedJson)
                        
                        completion(decodedJson.genres, nil)
                    } catch {
                        completion(nil, error)
                        debugPrint(error)
                    }
                }
            } else {
                completion(nil,response?.error)
            }
        }
    }
    
    static func getFilteredMovie(movie: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        
        let searchName = movie.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        performRequest(route: .search(movie: searchName)) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    
                    guard let jsonData = utf8Text.data(using: .utf8) else {
                        completion(nil, response?.error)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedJson = try decoder.decode(MDBResponse.self, from: jsonData)
                        dump(decodedJson)
                        
                        completion(decodedJson.results, nil)
                    } catch {
                        completion(nil, error)
                        
                    }
                }
            } else {
                completion(nil,response?.error)
            }
        }
    }
    
    
    
}
