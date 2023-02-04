//
//  SearchedMoviesListCollectionViewCell.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 03/02/23.
//

import UIKit

class SearchedMoviesListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var movieThumbImgView: UIImageView!
    @IBOutlet weak var halfContentView: UIView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var otherInfoLbl: UILabel!
    
    //MARK: - Local Variables
    var movie: Movie? {
        didSet {
            movieNameLbl.text = movie?.Title
            otherInfoLbl.text = movie?.Year
            let url = URL(string: movie?.Poster ?? "")
            movieThumbImgView.kf.setImage(with: url)
        }
    }
    
    //MARK: - Life Cycle Methodes
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
    }
    
    //MARK: - IBActions
    
    //MARK: - Other Methodes
    
    //MARK: - Delegates
    
}
