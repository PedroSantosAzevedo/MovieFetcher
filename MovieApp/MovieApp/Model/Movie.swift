//
//  Movie.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//


import Foundation

class Movie: Codable {
    
    let id: Int?
    let title: String?
    let overview: String?
    let genreIDs: [Int]?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    var isFavorite:Bool?
    
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case isFavorite
    }
}
