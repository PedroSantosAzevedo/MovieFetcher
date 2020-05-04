//
//  GeneralResponse.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

struct MDBResponse: Codable {
    
    let page: Int
    let totalPages: Int
    let results: [Movie]?
}

extension MDBResponse {
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}
