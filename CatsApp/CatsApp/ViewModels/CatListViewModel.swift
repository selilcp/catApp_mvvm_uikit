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
}
