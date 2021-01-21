//
//  MovieTableViewCell.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell{
    
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    private let networkServices = NetworkServices.shared()
    
    func configureCell(with info: MoviesModel.List.Movie){
        let activityView = UIActivityIndicatorView()
        movieImageView.image = UIImage()
        movieImageView.clipsToBounds = true
        movieImageView.addSubview(activityView)
        movieImageView.layer.cornerRadius = 5
        activityView.center = movieImageView.center
        activityView.startAnimating()
        
        networkServices.getImage(url: info.poster, handler: { [weak self] (data, error) in
            if let _data = data {
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                    self?.movieImageView.image = UIImage(data: _data)
                    self?.movieImageView.contentMode = .scaleAspectFill
                }
            }
        })
        
        movieNameLabel.numberOfLines = 2
        movieNameLabel.lineBreakMode = .byWordWrapping
        movieNameLabel.adjustsFontSizeToFitWidth = true
        movieNameLabel.minimumScaleFactor = 0.8
        movieNameLabel.text = info.title
        
        movieYearLabel.numberOfLines = 2
        movieYearLabel.lineBreakMode = .byWordWrapping
        movieYearLabel.adjustsFontSizeToFitWidth = true
        movieYearLabel.minimumScaleFactor = 0.8
        movieYearLabel.text = "(\(info.year))"
        
        
    }
    
}
