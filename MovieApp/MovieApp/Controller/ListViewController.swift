//
//  ListViewController.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ListViewController: UIViewController{
    
    var isSearching:Bool = false
    var listView:ListView {return self.view as! ListView}
    
    override func viewDidLoad() {
        self.view = ListView()
        super.viewDidLoad()
        setDataSourceAndDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listView.collectionView.reloadData()
    }
    
    func setDataSourceAndDelegate(){
        
        listView.collectionView.delegate = self
        listView.collectionView.dataSource = self
        listView.searchBar.delegate = self
        
    }
}

extension ListViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isSearching{return DAO.shared.movies.count} else {return DAO.shared.filtered.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        //
        if !isSearching{
            let movie = DAO.shared.movies[indexPath.row]
            movie.isFavorite = false
            cell.setUp(movie:movie)
            cell.refreshFavorite()
        }else{
            let movie = DAO.shared.filtered[indexPath.row]
            movie.isFavorite = false
            cell.setUp(movie:movie)
            cell.refreshFavorite()
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == DAO.shared.movies.count - 1 {
            let page = DAO.shared.page + 1
            MovieClient.getPopular(page: page) { (movies, error) in
                if error == nil{
                    guard let movies = movies else {return}
                    DAO.shared.movies.append(contentsOf: movies)
                    self.listView.collectionView.reloadData()
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width * 0.8
        let height = self.view.frame.height/3
        let size:CGSize = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var movie = DAO.shared.movies[indexPath.row]
        if isSearching{movie = DAO.shared.filtered[indexPath.row]}
        let movieVc = MovieViewController()
        movieVc.movieView.delegate = self
        movieVc.setMovie(movie: movie)
        self.present(movieVc, animated: true)
        
    }
}


extension ListViewController:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        listView.collectionView.reloadData()
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text{
            if text != ""{
                filterMovies(name: text)
            }else{
                isSearching = false
                DAO.shared.filtered = []
                listView.collectionView.reloadData()
            }
        }else{
            isSearching = false
            DAO.shared.filtered = []
            listView.collectionView.reloadData()
        }
        searchBar.endEditing(true)
    }
    
    
    func filterMovies(name:String){
        self.isSearching = true
        
        DAO.shared.filtered = []
        
        MovieClient.getFilteredMovie(movie: name) { (result, error) in
            if error != nil{
                //add alert
            }else{
                guard let result = result else{ return}
                DAO.shared.filtered = result
                self.listView.collectionView.reloadData()
            }
        }
        
    }
    
}



