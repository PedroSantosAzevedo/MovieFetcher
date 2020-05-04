//
//  MovieView.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 07/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieView: UIView {
    
    //MARK:- Constraints
    
    var myGenres:[String] = []
    var movie:Movie?
    var delegate:CellUpdate?
    
    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var colorStripe:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var bottonColorStripe:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var movieReleaseDate:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    
    lazy var movieName:UILabel = {
        let label = UILabel()
        addSubview(label)
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        let normalButtonImage = UIImage(imageLiteralResourceName: "favorite_empty_icon")
        button.setImage(normalButtonImage, for: .normal)
        button.contentMode = .center
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(favoriteMovie), for: .touchDown)
        return button
    }()
    
    lazy var movieDescription:UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        textView.isEditable = false
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .clear
        addSubview(textView)
        return textView
    }()
    
    lazy var genres:UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        textView.isEditable = false
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = self.myGenres.joined(separator: ",")
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .clear
        addSubview(textView)
        return textView
    }()
    
    
    //MARK:- Init methods
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.init(hex: .gray)
        
    }
    override func layoutSubviews() {
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func favoriteMovie(){
        guard let movie = movie else {return}
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
        delegate?.updateList()
    }
    
    
    
    
    //MARK: - Constraints
    private func setConstraints(){
        
        poster.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        poster.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        poster.heightAnchor.constraint(equalToConstant: frame.height/2).isActive = true
        
        favoriteButton.bottomAnchor.constraint(equalTo: poster.bottomAnchor, constant: -frame.height/20).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: frame.height/15).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: frame.height/15).isActive = true
        
        movieName.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: frame.height/35).isActive = true
        movieName.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.height/25).isActive = true
        movieName.heightAnchor.constraint(equalToConstant: frame.height/20).isActive = true
        movieName.widthAnchor.constraint(equalToConstant: frame.width/2.5).isActive = true
        
        movieReleaseDate.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: frame.height/35).isActive = true
        movieReleaseDate.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        movieReleaseDate.heightAnchor.constraint(equalToConstant: frame.height/20).isActive = true
        movieReleaseDate.widthAnchor.constraint(equalToConstant: frame.width/2.5).isActive = true
        
        colorStripe.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor,constant: 10).isActive = true
        colorStripe.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        colorStripe.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        colorStripe.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        movieDescription.topAnchor.constraint(equalTo: colorStripe.bottomAnchor,constant: 10).isActive = true
        movieDescription.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        movieDescription.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        movieDescription.heightAnchor.constraint(equalToConstant: frame.height/7).isActive = true
        
        bottonColorStripe.topAnchor.constraint(equalTo: movieDescription.bottomAnchor,constant: 10).isActive = true
        bottonColorStripe.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottonColorStripe.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottonColorStripe.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        genres.topAnchor.constraint(equalTo: bottonColorStripe.bottomAnchor,constant: 10).isActive = true
        genres.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        genres.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        genres.heightAnchor.constraint(equalToConstant: frame.height/7).isActive = true
        
    }
    
    
}
