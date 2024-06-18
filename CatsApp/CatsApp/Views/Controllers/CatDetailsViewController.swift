//
//  CatDetailsViewController.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

class CatDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var catImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var descriptionText: UITextView!
    @IBOutlet private weak var favButton: UIButton!
    
    var viewModel:CatDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }
    
    @IBAction func favouriteAction(_ sender:UIButton){
        guard let viewModel = viewModel else { return }
        if viewModel.isFavourite{
            viewModel.removeFromFavourite(cat: viewModel.cat)
        }else{
            viewModel.setFavourite(cat: viewModel.cat)
        }
        viewModel.isFavourite = !viewModel.isFavourite
        updateFavouriteImage(isFavourite: viewModel.isFavourite)
    }
    
    func populateData(){
        guard let viewModel = viewModel else { return }
        title = viewModel.cat.name
        titleLabel.text = viewModel.cat.name
        originLabel.text = viewModel.cat.origin
        descriptionText.text = viewModel.cat.description
        if let imageURLSting = viewModel.cat.image?.url,
           let imageURL = URL(string: imageURLSting){
            catImageView.loadImageWithURL(imageURL)
        }
        updateFavouriteImage(isFavourite: viewModel.isFavourite)
    }
    
    func updateFavouriteImage(isFavourite:Bool){
        let buttonImage = isFavourite ? UIImage(named: "favourite") : UIImage(named: "unFavourite")
        favButton.setImage(buttonImage, for: .normal)
    }

}
