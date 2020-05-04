//
//  GenreListResponse.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

struct GenreListResponse: Codable {

    let genres: [Genre]
}

extension GenreListResponse {
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
