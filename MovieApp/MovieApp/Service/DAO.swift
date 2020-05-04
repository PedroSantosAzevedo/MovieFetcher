//
//  DAO.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation


class DAO{
    
    static var shared = DAO()
    
    var page = 1
    var movies:[Movie] = []
    var favorites:[Movie] = []
    var filtered:[Movie] = []
    var genreList:[Genre] = []
    var filters:[String] = ["Genre","Title","Year"]
    var filteredFavorites:[Movie] = []
}
