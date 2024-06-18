//
//  CatsListingTableViewCell.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

class CatsListingTableViewCell: UITableViewCell {
    
    var cat:Cat?

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    func updateUI(cat:Cat){
        self.cat = cat
        titleLabel.text = cat.name
        originLabel.text = cat.origin
        catImageView.image = nil
        if let urlString = cat.image?.url,
           let url = URL(string: urlString){
            catImageView.loadImageWithURL(url)
        }
    }
    
}
