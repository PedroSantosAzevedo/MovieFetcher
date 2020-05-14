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
    var viewModel:MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = MovieView()
        binding()
        setActions()
    }
    
    func setActions(){
        movieView.favoriteButton.addTarget(self, action: #selector(favMovie), for: .touchDown)
    }
    
    func binding(){
        guard let viewModel = viewModel else {return}

        
        viewModel.title.bind { (title) in
            self.movieView.movieName.text = title
        }
        
        viewModel.description.bind { (description) in
            self.movieView.movieDescription.text = description
        }
        
        viewModel.releaseDate.bind { (date) in
            self.movieView.movieReleaseDate.text = date
        }
        viewModel.url.bind { (url) in
            self.movieView.poster.kf.indicatorType = .activity
            self.movieView.poster.kf.setImage(with: url)
        }
        
        viewModel.genres.bind { (genres) in
            self.movieView.genres.text = genres
        }
        
        viewModel.isFavorite.bind { (isFavorited) in
            if !isFavorited{
            self.movieView.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_empty_icon"), for: .normal)
                viewModel.movie?.isFavorite = false
            }else{
                self.movieView.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_full_icon"), for: .normal)
                
            }
        }
        
    }
    
    @objc private func favMovie(){
        guard let viewModel = self.viewModel else {return}
        viewModel.favMovie()
        delegate?.updateList()
    }

}

protocol CellUpdate{
    func updateList()
}
