//
//  CatDetailViewModel.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation


class CatDetailViewModel{
    
    let service: CatDetailsService
    var cat:Cat
    var isFavourite:Bool
    
    init(detailsService:CatDetailsService,
         cat:Cat,
         isFavourite:Bool){
        self.service = detailsService
        self.cat = cat
        self.isFavourite = isFavourite
    }
    
    func removeFromFavourite(cat:Cat){
        service.removeFavouriteCat(id: cat.id)
    }
    
    func setFavourite(cat:Cat){
        service.setAsFavourite(cat: cat)
    }
}
