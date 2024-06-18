//
//  CatListViewModel.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

class CatListViewModel{
    
    var cats:[Cat]?
    private let service: DefaultCatsListingService
    
    init (service: DefaultCatsListingService) {
        self.service = service
    }
    
    var catsCount: Int?{
        return cats?.count
    }
    
    func fetchCatList(complitionHandler: @escaping (APIError?) -> () ){
        service.getCats(completionHandler: { [weak self] (content, error) in
            self?.cats = content
            complitionHandler(error)
        })
    }
    
    func getCatWithPosition(pos:Int) -> Cat?{
        guard let cats = cats else { return nil }
        if cats.indices.contains(pos){
            return cats[pos]
        }
        return nil
    }
    
    func isFavourite(cat:Cat) -> Bool{
        return service.favouriteCatCheck(id: cat.id)
    }
    
    func removeFromFavourite(cat:Cat){
        service.removeFavouriteCat(id: cat.id)
    }
    
    func setFavourite(cat:Cat){
        service.setAsFavourite(cat: cat)
    }
}
