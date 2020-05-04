//
//  FavoritesViewController.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController:UIViewController{
    
    var favView:FavoritesView {return self.view as! FavoritesView}
    var isSearching:Bool = false
    var searchFilter:String = DAO.shared.filters[1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.init(hex: .gray)
        self.view = FavoritesView()
        favView.favoritesTableView.delegate = self
        favView.favoritesTableView.dataSource = self
        favView.searchBar.delegate = self
        favView.filterTableView.delegate = self
        favView.filterTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favView.favoritesTableView.reloadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //make no favorites warning appear
        if DAO.shared.favorites.isEmpty{
            favView.warningLabel.isHidden = false
        }else{
            favView.warningLabel.isHidden = true
        }
    }
}

//MARK: - Extensions
extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == favView.favoritesTableView{
            if !isSearching{
                return DAO.shared.favorites.count
            } else {
                return DAO.shared.filteredFavorites.count}
        }else{
            return DAO.shared.filters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == favView.favoritesTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteMovieTableViewCell
            if !isSearching{
                let movie = DAO.shared.favorites[indexPath.row]
                movie.isFavorite = false
                cell.setUp(movie:movie)
            }else{
                let movie = DAO.shared.filteredFavorites[indexPath.row]
                movie.isFavorite = false
                cell.setUp(movie:movie)
            }
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = DAO.shared.filters[indexPath.row]
            cell.backgroundColor = .gray
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == favView.favoritesTableView{
            return tableView.frame.height/3.5
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == favView.favoritesTableView{
            return 200
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == favView.favoritesTableView{
            var movie = DAO.shared.favorites[indexPath.row]
            if isSearching{movie = DAO.shared.filteredFavorites[indexPath.row]}
            movie.isFavorite = true
            let movieVc = MovieViewController()
            movieVc.setMovie(movie: movie)
            movieVc.movieView.delegate = self
            //            movieVc.delegate = self.listView
            self.present(movieVc, animated: true)
        }else{
            self.searchFilter = DAO.shared.filters[indexPath.row]
            self.favView.filterTableView.isHidden = true
            self.favView.searchBar.placeholder = "Search by \(searchFilter)"
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == favView.favoritesTableView{
            if !self.isSearching{
                let delete = deleteAction(at: indexPath)
                delete.backgroundColor = .red
                return UISwipeActionsConfiguration(actions: [delete])
            }else{
                return UISwipeActionsConfiguration()
            }
        }
        return UISwipeActionsConfiguration()
    }
    
    func deleteAction(at indexPath:IndexPath) ->UIContextualAction{
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            DAO.shared.favorites.remove(at: indexPath.row)
            
            let cell  = self.favView.favoritesTableView.cellForRow(at: indexPath) as! FavoriteMovieTableViewCell
            for movieIndex in 0...DAO.shared.movies.count - 1{
                if cell.movie.id == DAO.shared.movies[movieIndex].id{
                    
                    DAO.shared.movies[movieIndex].isFavorite = false
                    
                    break
                }
            }
            
            
            self.favView.favoritesTableView.reloadData()
        }
        
        return action
    }
    
}



extension FavoritesViewController:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.favView.favoritesTableView.reloadData()
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text{
            if text != ""{
                
                filterMovies(name: text, type: searchFilter)
                
                favView.favoritesTableView.reloadData()
                
            }else{
                isSearching = false
                DAO.shared.filteredFavorites = []
                favView.favoritesTableView.reloadData()
            }
        }else{
            isSearching = false
            DAO.shared.filteredFavorites   = []
            favView.favoritesTableView.reloadData()
        }
        searchBar.endEditing(true)
        favView.favoritesTableView.reloadData()
    }
    
    
    func filterMovies(name:String,type:String){
        self.isSearching = true
        
        DAO.shared.filteredFavorites = []
        var filtered:[Movie] = []
        switch type {
        case "Genre":
            
            var movieIds:[String] = []
            
            for movie in DAO.shared.favorites{
                for genre in DAO.shared.genreList{
                    for id in movie.genreIDs!{
                        if genre.id == id{
                            movieIds.append(genre.name ?? "empty")
                        }
                    }
                }
                for id in movieIds{
                    if id.lowercased() == name.lowercased(){
                        filtered.append(movie)
                        break
                    }
                }
            }
            self.favView.favoritesTableView.reloadData()
            
            
            
        case "Year":
            for movie in DAO.shared.favorites{
                let year = movie.releaseDate?.components(separatedBy: "-")[0]
                if year == name{
                    DAO.shared.filteredFavorites.append(movie)
                }
            }
            
        case "Title":
            
            for movie in DAO.shared.favorites{
                if (movie.title?.lowercased().contains(name.lowercased()))!{
                    
                    DAO.shared.filteredFavorites.append(movie)
                    
                }
            }
            
        default:
            debugPrint("not a correct value")
        }
        
        
    }
    
}

extension FavoritesViewController:CellUpdate{
    func updateList() {
        self.favView.favoritesTableView.reloadData()
    }
}
