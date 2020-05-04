//
//  FavoritesView.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 08/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit


class FavoritesView:UIView{
    
    //MARK:- Variables
    
    var safeArea:UILayoutGuide!
    
    lazy var favoritesTableView:UITableView = {
        let tableView = UITableView()
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        return tableView
    }()
    
    lazy var filterTableView:UITableView = {
        let tableView = UITableView()
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.isHidden = true
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.init(hex: .gray)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        return tableView
    }()
    
    lazy var warningLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingHead
        label.alpha = 0.8
        label.textColor = .white
        label.font = label.font.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        label.textAlignment = .center
        label.text = "You don't have any favorite movies yet!"
        addSubview(label)
        return label
    }()
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.barTintColor = .clear
        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    lazy var filterButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.backgroundColor = .black
        let normalButtonImage = UIImage(imageLiteralResourceName: "filter_icon")
        button.setImage(normalButtonImage, for: .normal)
        button.contentMode = .center
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(showFilterOptions), for: .touchDown)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        safeArea = layoutMarginsGuide
        self.backgroundColor = UIColor.init(hex: MyColors.darkGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setContraints()
        favoritesTableView.reloadData()
    }
    
    @objc private func showFilterOptions(){
        if filterTableView.isHidden{
            filterTableView.isHidden = false
            self.bringSubviewToFront(self.filterTableView)
        }else{
            filterTableView.isHidden = true
        }
    }
    
    
    //MARK:- Constraints
    private func setContraints(){
        
        searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width/5).isActive = true
        searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: frame.height/8).isActive = true
        
        filterButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        filterButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        filterButton.rightAnchor.constraint(equalTo: searchBar.leftAnchor, constant: 0).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: frame.height/8).isActive = true
        
        filterTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        filterTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        filterTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        filterTableView.heightAnchor.constraint(equalToConstant: frame.height/7).isActive = true
        
        favoritesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        favoritesTableView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        favoritesTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        favoritesTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        warningLabel.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        warningLabel.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        warningLabel.heightAnchor.constraint(equalToConstant:frame.height/4).isActive = true
        warningLabel.widthAnchor.constraint(lessThanOrEqualToConstant:frame.width).isActive = true
    }
    
}
