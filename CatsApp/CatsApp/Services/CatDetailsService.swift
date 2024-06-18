//
//  CatDetailsService.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import CoreData

protocol CatDetailsService {
    func removeFavouriteCat(id:String)
    func setAsFavourite(cat: Cat)
}

class DefaultCatDetailsService: CatDetailsService{
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
