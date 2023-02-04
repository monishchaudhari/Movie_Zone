//
//  SearchedMoviesListViewController.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 03/02/23.
//

import UIKit
import Kingfisher
import MBProgressHUD

class SearchedMoviesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - IBOutlets
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var showingResultLbl: UILabel!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    //MARK: - Local Variables
    private var movieArray = [Movie]()
    var searchedText = ""
    
    //MARK: - Life Cycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showingResultLbl.text = "Showing results for '\(searchedText.trimmingCharacters(in: .whitespacesAndNewlines))'"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("SearchedMoviesListViewController deinit called")
    }
    
    //MARK: - IBActions
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Other Methodes
    func setSearchedMovies(_ movies: [Movie]) {
        movieArray = movies
        
        DispatchQueue.main.async {
            self.resultsCollectionView.reloadData()
        }
    }
    
    private func fetchMovieDetails(for imdbID: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        _ = APIManager.shared.makeAPICall(
            endPoint: APIManager.shared.searchByIMDBId + imdbID,
            method: .GET,
            requestBody: nil) { data, error, response in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                if let httpResponse = response as? HTTPURLResponse, let responseData = data {
                    switch httpResponse.statusCode {
                    case 200:
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                            let decodedResponse = try decoder.decode(Movie.self, from: responseData)
                            if decodedResponse.Response?.caseInsensitiveCompare("False") == .orderedSame {
                                DispatchQueue.main.async {
                                    self.showAlert("", alert_message: decodedResponse.Error ?? "Could not load details for selected movie.")
                                }
                            } else {
                                DispatchQueue.main.async {
                                let movieDetailsVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
                                    self.present(movieDetailsVC, animated: true) {
                                        movieDetailsVC.updateMovieDetails(decodedResponse)
                                    }
                                }
                            }
                            
                        } catch let error {
                            DispatchQueue.main.async {
                                self.showAlert("Cannot fetch movie", alert_message: error.localizedDescription)
                            }
                        }
                        break
                    default:
                        DispatchQueue.main.async {
                            self.showAlert("Failed to fetch movies", alert_message: httpResponse.description)
                        }
                        break
                    }
                }
            }
    }
    
    //MARK: - Delegates
    
    //MARK: - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchedMoviesListCollectionViewCell", for: indexPath) as! SearchedMoviesListCollectionViewCell
        let movie = movieArray[indexPath.row]
        cell.movie = movie
        cell.movieThumbImgView.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width/2) - 10
        let height = (width/2) * 3
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.fetchMovieDetails(for: movieArray[indexPath.row].imdbID ?? "")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
