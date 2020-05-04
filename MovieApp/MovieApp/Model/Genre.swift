//
//  Genre.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int?
    let name: String?
}

extension Genre {

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
