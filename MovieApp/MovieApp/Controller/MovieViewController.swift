//
//  MovieViewController.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit


class MovieViewController: UIViewController {
    
    var movieView:MovieView {return self.view as! MovieView}
    var delegate:CellUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = MovieView()
        
    }
    
    func setMovie(movie:Movie){
        movieView.movie = movie
        movieView.movieDescription.text = movie.overview
        movieView.movieName.text = movie.title
        movieView.movieReleaseDate.text = movie.releaseDate
        
        let imageURL:URL?
        if let path = movie.backdropPath {
            imageURL = ImageEndpoint.image(width:780, path: path).completeURL
        }else{
            imageURL = nil
        }
        movieView.poster.kf.indicatorType = .activity
        movieView.poster.kf.setImage(with: imageURL)
        
        getGenres(movie:movie)
        
        refreshFavorite(movie:movie)
        
    }
    
    func getGenres(movie:Movie){
        guard let movieIds:[Int] = movie.genreIDs else {return}
        var myGenres:[String] = []
        for genre in DAO.shared.genreList{
            for id in movieIds{
                if id == genre.id{
                    guard let name = genre.name else {return}
                    myGenres.append(name)
                }
            }
        }
        movieView.genres.text = myGenres.joined(separator: "    ")
    }
    
    func refreshFavorite(movie:Movie){
        if !movie.isFavorite! {
            movieView.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_empty_icon"), for: .normal)
        }else{
            movieView.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_full_icon"), for: .normal)
        }
    }
    
    
}

protocol CellUpdate{
    func updateList()
}
