//
//  extensions and protocols.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 09/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extensions




extension UIColor {
    convenience init?(hex: MyColors) {
        let r, g, b, a: CGFloat
        let hex = hex.rawValue
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x0000FF) / 255.0
                    a = CGFloat(1.0)
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}



extension ListViewController:CellUpdate{
    func updateList() {
        self.listView.collectionView.reloadData()
    }
    
}


extension ListViewController:UpdateCollectionView{
    func update() {
        listView.collectionView.reloadData()
    }
    
}

extension UIViewController{
    
    func displayError(errorMessage:String,errorTitle:String){
        
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
