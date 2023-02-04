//
//  MovieDetailsViewController.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 04/02/23.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    @IBOutlet weak var mainBgView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    @IBOutlet weak var moviePosterImgView: UIImageView!
    @IBOutlet weak var imdbRatingBGView: UIView!
    @IBOutlet weak var imdbRatingImgView: UIImageView!
    @IBOutlet weak var imdbRatingLargeLbl: UILabel!
    
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var genereLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    @IBOutlet weak var releasedDateLbl: UILabel!
    @IBOutlet weak var directorNameLbl: UILabel!
    @IBOutlet weak var writerNameLbl: UILabel!
    @IBOutlet weak var actorNameLbl: UILabel!
    
    @IBOutlet weak var plotLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var awardsLbl: UILabel!
    
    @IBOutlet weak var boxOfficeRatingLbl: UILabel!
    @IBOutlet weak var imdbRatingLbl: UILabel!
    @IBOutlet weak var imdbVotesLbl: UILabel!
    @IBOutlet weak var metascoreLbl: UILabel!
    @IBOutlet weak var internetMovieDBRatingLbl: UILabel!
    @IBOutlet weak var rottenTomatoesRatingLbl: UILabel!
    @IBOutlet weak var metacriticRatingLbl: UILabel!
    
    //MARK: - Local Variables
    private var movie: Movie?
    
    //MARK: - Life Cycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imdbRatingBGView.makeRoundedCorners()
        moviePosterImgView.layer.cornerRadius = 5.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("MovieDetailsViewController deinit called")
    }
    
    //MARK: - IBActions
    @IBAction func didTapDismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Other Methodes
    func updateMovieDetails(_ movie: Movie) {
        self.movie = movie
        
        let url = URL(string: movie.Poster ?? "")
        moviePosterImgView.kf.setImage(with: url)
        imdbRatingLargeLbl.text = movie.imdbRating ?? "0.0"
        
        movieNameLbl.text = movie.Title
        genereLbl.text = movie.Genre
        durationLbl.text = "Duration: \(movie.Runtime ?? "0 min") | \(movie.Rated ?? "") rated"
        
        releasedDateLbl.text = movie.Released ?? "Not available"
        directorNameLbl.text = movie.Director ?? "Not available"
        writerNameLbl.text = movie.Writer ?? "Not available"
        actorNameLbl.text = movie.Actors ?? "Not available"
        
        plotLbl.text = movie.Plot ?? "Not available"
        languageLbl.text = movie.Language ?? "Not available"
        countryLbl.text = movie.Country ?? "Not available"
        awardsLbl.text = movie.Awards ?? "Not available"
        
        boxOfficeRatingLbl.text = movie.BoxOffice ?? "Not available"
        imdbRatingLbl.text = movie.imdbRating ?? "Not available"
        imdbVotesLbl.text = movie.imdbVotes ?? "Not available"
        metascoreLbl.text = movie.Metascore ?? "Not available"
        internetMovieDBRatingLbl.text = movie.Ratings?.first(where: {$0.Source == "Internet Movie Database"})?.Value ?? "Not available"
        rottenTomatoesRatingLbl.text = movie.Ratings?.first(where: {$0.Source == "Rotten Tomatoes"})?.Value ?? "Not available"
        metacriticRatingLbl.text = movie.Ratings?.first(where: {$0.Source == "Metacritic"})?.Value ?? "Not available"
        
    }
    
    //MARK: - Delegates
    
}
