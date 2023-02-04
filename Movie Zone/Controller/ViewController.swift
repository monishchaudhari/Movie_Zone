//
//  ViewController.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 03/02/23.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var iconImgBGView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var movieNameTxtFldBGView: UIView!
    @IBOutlet weak var movieNameTxtFld: UITextField!
    @IBOutlet weak var searchMoviesBtn: UIButton!
    
    //MARK: - Local Variables
    
    //MARK: - Life Cycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconImgBGView.makeRoundedCorners()
        movieNameTxtFldBGView.makeRoundedCorners()
        searchMoviesBtn.makeRoundedCorners()
        
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
        print("ViewController deinit called")
    }
    
    //MARK: - IBActions
    @IBAction func didTapSearchMovieBtn(_ sender: UIButton) {
        resignFirstResponder()
        
        if movieNameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false {
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.movieNameTxtFld.center.x - 10, y: self.movieNameTxtFld.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.movieNameTxtFld.center.x + 10, y: self.movieNameTxtFld.center.y))
            DispatchQueue.main.async {
                self.movieNameTxtFld.layer.add(animation, forKey: "position")
                self.movieNameTxtFld.becomeFirstResponder()
            }
            return
        }
        
        searchMovies()
    }
    
    
    //MARK: - Other Methodes
    private func searchMovies() {
        let searchedTxt = movieNameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        _ = APIManager.shared.makeAPICall(
            endPoint: APIManager.shared.searchMovies + searchedTxt,
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
                            let decodedResponse = try decoder.decode(MovieSearchAPIResponse.self, from: responseData)
                            
                            if decodedResponse.Response?.caseInsensitiveCompare("False") == .orderedSame {
                                DispatchQueue.main.async {
                                    self.showAlert("", alert_message: decodedResponse.Error ?? "Please try with different movie name")
                                }
                            } else {
                                DispatchQueue.main.async {
                                let searchedListVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SearchedMoviesListViewController") as! SearchedMoviesListViewController
                                    searchedListVC.searchedText = searchedTxt
                                    self.navigationController?.pushViewController(searchedListVC, animated: true)
                                    searchedListVC.setSearchedMovies(decodedResponse.Search ?? [Movie]())
                                }
                            }
                            
                        } catch let error {
                            DispatchQueue.main.async {
                                self.showAlert("Cannot search movies", alert_message: error.localizedDescription)
                            }
                        }
                        break
                    default:
                        DispatchQueue.main.async {
                            self.showAlert("Failed to search movies", alert_message: httpResponse.description)
                        }
                        break
                    }
                }
            }
        
    }
    
    //MARK: - Delegates
    
}

