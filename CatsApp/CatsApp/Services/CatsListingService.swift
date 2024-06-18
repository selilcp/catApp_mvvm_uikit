//
//  CatsListingService.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

protocol CatsListingService {
    func getCats(completionHandler: @escaping ([Cat]?, APIError?) -> ())
    func favouriteCatCheck(id:String) -> Bool
    func removeFavouriteCat(id:String)
    func setAsFavourite(cat: Cat)
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
    func favouriteCatCheck(id:String) -> Bool{
        let request = SavedCat.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(request)
            return entities.count > 0
        } catch  {
            return false
        }
    }
    func removeFavouriteCat(id:String){
        let request = SavedCat.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(request)
            if let firstData = entities.first{
                PersistenceController.shared.container.viewContext.delete(firstData)
            }
            _ = PersistenceController.shared.save()
        } catch  {
            return
        }
    }
    func setAsFavourite(cat: Cat){
        let entity = SavedCat(context: PersistenceController.shared.container.viewContext)
        entity.id = cat.id
        entity.name = cat.name
        _ = PersistenceController.shared.save()
    }
}
