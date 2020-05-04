//
//  TabBarViewController.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var collectionDelegate:UpdateCollectionView!
    
    //MARK: - Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .clear
        setUpBar()
    }
    
    
    //MARK: - Complimentary methods
    private func setUpBar(){
        
        //MoviesViewController
        
        let listView = ListViewController()
        listView.title = "Movies"
        //        collectionDelegate = listView
        let moviesBar = UINavigationController(rootViewController: listView)
        moviesBar.title = "Movies"
        moviesBar.tabBarItem.image = UIImage(named: "list_icon")
        moviesBar.tabBarItem.selectedImage = UIImage(named: "list_icon")
        
        //FavoritesViewController
        let fav = FavoritesViewController()
        fav.title = "Favorites"
        let favoritesBar = UINavigationController(rootViewController: fav)
        favoritesBar.title = "Favorites"
        favoritesBar.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        favoritesBar.tabBarItem.selectedImage = UIImage(named: "favorite_empty_icon")
        
        
        viewControllers = [moviesBar,favoritesBar]
        
    }
    
}

protocol UpdateCollectionView:Any{
    func update()
    
}
