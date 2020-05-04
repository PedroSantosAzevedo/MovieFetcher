//
//  MovieCollectionViewCell.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit
import MarqueeLabel

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    var movie:Movie!
    
    
    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var colorStripe:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.init(hex: .gray)
        image.alpha = 0.2
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        let normalButtonImage = UIImage(imageLiteralResourceName: "favorite_gray_icon")
        button.setImage(normalButtonImage, for: .normal)
        button.contentMode = .center
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(favoriteMovie), for: .touchDown)
        return button
    }()
    
    
    lazy var title:MarqueeLabel = {
        let label = MarqueeLabel(frame: .zero, duration: 6, fadeLength: 5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        label.type = .left
        return label
    }()
    
    //MARK: - Init methods
    func setUp(movie:Movie){
        self.movie = movie
        self.poster.layer.masksToBounds = true
        let imageURL:URL?
        if let path = movie.backdropPath {
            imageURL = ImageEndpoint.image(width:780, path: path).completeURL
        }else{
            imageURL = nil
        }
        self.poster.kf.indicatorType = .activity
        self.poster.kf.setImage(with: imageURL)
        self.title.text = movie.title
        
    }
    
    func setView(){
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        safeArea = layoutMarginsGuide
        setContraints()
        setView()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Complimentary Methods
    
    
    
    @objc private func favoriteMovie(){
        let myId = movie.id
        if let movie = self.movie{
            if movie.isFavorite! {
                movie.isFavorite = false
                for movieIndex in 0...DAO.shared.favorites.count{
                    if DAO.shared.favorites[movieIndex].id == myId{
                        DAO.shared.favorites.remove(at: movieIndex)
                        break
                    }
                }
                self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_gray_icon"), for: .normal)
            }else{
                movie.isFavorite = true
                var alreadyFavorite = false
                for movieFav in DAO.shared.favorites{
                    if movie.id == movieFav.id{
                        alreadyFavorite = true
                        break
                    }
                }
                if alreadyFavorite != true{
                    movie.isFavorite = true
                    DAO.shared.favorites.append(movie)
                    
                }
                self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_full_icon"), for: .normal)
            }
        }
    }
    
    func refreshFavorite(){
        
        if let movie = self.movie{
            
            for movieFav in DAO.shared.favorites{
                if movie.id == movieFav.id{
                    movie.isFavorite = true
                    break
                }
            }
            if !movie.isFavorite! {
                self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_gray_icon"), for: .normal)
            }else{
                self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_full_icon"), for: .normal)
            }
        }
        
    }
    //MARK:- Contraints
    func setContraints(){
        
        //Favorite Image
        colorStripe.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        colorStripe.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        colorStripe.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        colorStripe.heightAnchor.constraint(equalToConstant: frame.height/3.5).isActive = true
        
        //Poster
        poster.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        poster.setContentHuggingPriority(.defaultHigh, for: .vertical)
        poster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: colorStripe.topAnchor).isActive = true
        poster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        //Favorite Button
        favoriteButton.heightAnchor.constraint(equalToConstant: frame.height/8).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: frame.height/8).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: poster.bottomAnchor,constant: -15).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: colorStripe.rightAnchor, constant: -frame.width/8).isActive = true
        
        //title
        title.centerYAnchor.constraint(equalTo: colorStripe.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: colorStripe.leftAnchor, constant: frame.width/15).isActive = true
        title.rightAnchor.constraint(equalTo: colorStripe.rightAnchor).isActive = true
        
    }
    
}
