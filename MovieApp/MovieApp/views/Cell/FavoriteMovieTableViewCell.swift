//
//  FavoriteMovieTableViewCell.swift
//  InChurchIosChallenge
//
//  Created by Pedro Azevedo on 09/04/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteMovieTableViewCell: UITableViewCell {
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    var movie:Movie!
    var listIndex:IndexPath!
    
    lazy var posterImage:UIImageView = {
        let image = UIImageView()
        addSubview(image)
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var movieTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    
    lazy var releaseYear:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    
    lazy var movieDescription:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.font = label.font.withSize(17)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 8
        self.selectionStyle = .none
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        safeArea = layoutMarginsGuide
        setConstraints()
        isUserInteractionEnabled = true
        
    }
    
    func setUp(movie:Movie){
        self.movie = movie
        self.posterImage.layer.masksToBounds = true
        guard let imageUrl = movie.posterPath else {fatalError("could not get poster url")}
        updatePosterImage(cell: self, imageUrl: imageUrl)
        self.movieTitle.text = movie.title
        movieDescription.text = movie.overview
        let year = movie.releaseDate!.components(separatedBy: "-")
        self.releaseYear.text = year[0]
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updatePosterImage(cell:FavoriteMovieTableViewCell,imageUrl:String){
        
        let imageURL:URL?
        if let path = movie.backdropPath {
            imageURL = ImageEndpoint.image(width:780, path: path).completeURL
        }else{
            imageURL = nil
        }
        self.posterImage.kf.indicatorType = .activity
        self.posterImage.kf.setImage(with: imageURL)
        
        
    }
    
    //MARK: - Constraints
    func setConstraints(){
        
        posterImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        posterImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: frame.height*2.5).isActive = true
        
        releaseYear.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        releaseYear.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0).isActive = true
        releaseYear.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        movieTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        movieTitle.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        movieTitle.rightAnchor.constraint(equalTo:releaseYear.leftAnchor).isActive = true
        
        
        movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        movieDescription.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        movieDescription.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        movieDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
}

