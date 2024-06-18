//
//  CatsListingTableViewCell.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

protocol CatsListingTableViewCellDelegate:NSObject {
    func favouriteClick(cat:Cat)
}


class CatsListingTableViewCell: UITableViewCell {
    
    var cat:Cat?
    weak var delegate:CatsListingTableViewCellDelegate?

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favouriteAction(_ sender:UIButton){
        if let cat = cat {
            delegate?.favouriteClick(cat: cat)
        }
    }
    
    func updateUI(cat:Cat,
                  favourite:Bool){
        self.cat = cat
        titleLabel.text = cat.name
        originLabel.text = cat.origin
        catImageView.image = nil
        if let urlString = cat.image?.url,
           let url = URL(string: urlString){
            catImageView.loadImageWithURL(url)
        }
        updateFavouriteImage(saved: favourite)
    }
    
    func updateFavouriteImage(saved:Bool){
        let buttonImage = saved ? UIImage(named: "favourite") : UIImage(named: "unFavourite")
        favButton.setImage(buttonImage, for: .normal)
    }
    
}
