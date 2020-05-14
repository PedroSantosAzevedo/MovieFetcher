//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Pedro Azevedo on 14/05/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation


class MovieViewModel {
    
    var movie:Movie!
    var title:Box<String> = Box("TitlePlaceHolder")
    var description:Box<String> = Box("OverView Placeholder")
    var releaseDate:Box<String> = Box("30/05/1996")
    var genres:Box<String> = Box("")
    var url:Box<URL?> = Box(URL(string: ""))
    var isFavorite:Box<Bool> = Box(false)
    
    init(movie:Movie){
        self.movie = movie
        if let title = movie.title{
            self.title.value = title
        }
        if let desc = movie.overview{
            self.description.value = desc
        }
        if let release = movie.releaseDate{
            self.releaseDate.value = release
        }
        
        if let favorited = movie.isFavorite{
            self.isFavorite.value = favorited
        }
        
        getImageUrl(movie:movie)
        getIds(movie:movie)
    }
    
    
    func getImageUrl(movie:Movie){
        
        if let path = movie.backdropPath {
            url.value = ImageEndpoint.image(width:780, path: path).completeURL
        }else{
            url.value = nil
        }
    }
    
    
    func getIds(movie:Movie){
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
        genres.value = myGenres.joined(separator: "    ")
    }
   
}
