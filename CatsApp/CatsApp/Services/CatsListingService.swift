//
//  CatsListingService.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

protocol CatsListingService {
    func getCats(completionHandler: @escaping ([Cat]?, APIError?) -> ())
}

class DefaultCatsListingService: CatsListingService{
    func getCats(completionHandler: @escaping ([Cat]?, APIError?) -> ()) {
        let handler = CatListHandler()
        let apiLoader = APILoader(apiHandler: handler)
        
        apiLoader.loadAPIRequest(urlParam: nil,
                                 queryParam: nil,
                                 bodyParam: nil)
        { content, error in
            completionHandler(content ,error)
        }
    }
}
