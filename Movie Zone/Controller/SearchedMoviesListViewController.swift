//
//  SearchedMoviesListViewController.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 03/02/23.
//

import UIKit

class SearchedMoviesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var showingResultLbl: UILabel!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    //MARK: - Local Variables
    var dataSourceArray = [AnyObject]()
    
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
    
    //MARK: - Other Methodes
    
    //MARK: - Delegates
    
    //MARK: - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchedMoviesListCollectionViewCell", for: indexPath) as! SearchedMoviesListCollectionViewCell
        return cell
    }
    
}
