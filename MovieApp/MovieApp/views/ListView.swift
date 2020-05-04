//
//  ListView.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    var safeArea:UILayoutGuide!
    
    lazy var collectionView:UICollectionView = {
        
        //gridView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(0)
        flowLayout.minimumInteritemSpacing = CGFloat(0)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //cell setup
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return collectionView
        
    }()
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .clear
        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = "Search for movies"
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        safeArea = layoutMarginsGuide
        self.backgroundColor = UIColor.init(hex: MyColors.darkGray)
        
    }
    override func layoutSubviews() {
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Constraints
    private func setContraints(){
        
        searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: frame.height/8).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
}
