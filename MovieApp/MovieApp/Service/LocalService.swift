//
//  LocalService.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 09/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

final class LocalService {
    
    static let shared = LocalService()
    private init() {}
    
    //System default Documents Directory
    private static let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    // Get a URL to a file in documentsDir
    private func getURLInDocumentDir(for file: String) -> URL {
        return URL(fileURLWithPath: LocalService.documentsDir.appendingPathComponent(file + ".json"))
    }
    
    func saveFavorites() {
        
        let url = getURLInDocumentDir(for:"Favorites")
        
        do {
            try JSONEncoder().encode(DAO.shared.favorites).write(to: url)
            
        } catch {
            debugPrint("No favorites saved")
        }
    }
    
    func getFavorites() {
        let url = getURLInDocumentDir(for: "Favorites")
        do {
            let readData = try Data(contentsOf: url)
            DAO.shared.favorites = try JSONDecoder().decode([Movie].self, from: readData)
            
        } catch {
            debugPrint("Could not save favorites")
        }
        
    }
    
}
