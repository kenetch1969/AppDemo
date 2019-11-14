//
//  MoviesTableViewCell.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/13/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

protocol MoviesTableViewCellDelegate {
    func selectFavorite(favorite: Bool, tag: Int)
}

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var titleMovieValue: UILabel!
    @IBOutlet weak var genreMovieLabel: UILabel!
    @IBOutlet weak var genreMovieValue: UILabel!
    @IBOutlet weak var anioMovieLabel: UILabel!
    @IBOutlet weak var anioMovieValue: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var isFavorite = false
    var delegate: MoviesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorite(favorite: Bool) {
        self.isFavorite = favorite
        if isFavorite {
            self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        isFavorite = !isFavorite
        if isFavorite {
            self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            self.delegate?.selectFavorite(favorite: true, tag: self.tag)
        } else {
            self.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
             self.delegate?.selectFavorite(favorite: false, tag: self.tag)
        }
    }
}
