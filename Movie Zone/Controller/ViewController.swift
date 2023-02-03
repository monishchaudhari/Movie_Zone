//
//  ViewController.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 03/02/23.
//

import UIKit

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
        let searchedListVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SearchedMoviesListViewController") as! SearchedMoviesListViewController
        
        self.navigationController?.pushViewController(searchedListVC, animated: true)
        
    }
    
    
    
    //MARK: - Other Methodes
    
    //MARK: - Delegates
    
}

