//
//  DetailViewController.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/20/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var moviePlotLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var boxOfficeLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    
    var imdbID: String = "12345"
    private let networkServices = NetworkServices.shared()
    override func viewWillAppear(_ animated: Bool) {
        loadMovie(withID: imdbID)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //movieNameLabel.text = imdbID
    }
    func loadMovie(withID id: String){
        networkServices.searchMovie(with: imdbID) { [weak self] (movieObject, error) in
            if let movie = movieObject, error == nil {
                if movie.response.lowercased() ==  "true" {
                    DispatchQueue.main.async {
                    self?.movieNameLabel.text = movie.title
                    //moviePosterImage.text = movie.
                    self?.moviePlotLabel.text = movie.plot
                    self?.yearLabel.text = movie.year
                    self?.ratedLabel.text = movie.rated
                    self?.releasedLabel.text = movie.released
                    self?.genreLabel.text = movie.genre
                    self?.writerLabel.text = movie.writer
                    self?.actorsLabel.text = movie.actors
                    self?.directorLabel.text = movie.director
                    self?.languagesLabel.text = movie.language
                    self?.boxOfficeLabel.text = movie.boxOffice
                    self?.productionLabel.text = movie.production
                    
                    self?.moviePosterImage.image = UIImage()
                    self?.moviePosterImage.clipsToBounds = true
                    //self?.moviePosterImage.addSubview(activityView)
//                    activityView.center = self.posterImageView.center
//                    activityView.startAnimating()
                    }
                    self?.networkServices.getImage(url: movie.poster, handler: { [weak self] (data, error) in
                        if let _data = data {
                            DispatchQueue.main.async {
//                                activityView.stopAnimating()
//                                activityView.removeFromSuperview()
                                self?.moviePosterImage.image = UIImage(data: _data)
                                self?.moviePosterImage.contentMode = .scaleAspectFill
                            }
                        }
                    })
                    
                }else{
                }
                
            }else{
            }
        }
    }

}

