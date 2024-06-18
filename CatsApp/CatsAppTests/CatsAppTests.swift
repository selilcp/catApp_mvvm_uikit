//
//  CatsAppTests.swift
//  CatsAppTests
//
//  Created by Selil on 18/06/2024.
//

import XCTest
@testable import CatsApp

final class CatListViewModelTests: XCTestCase {

    func testGetCatWithPosition() throws {
     
        var cats: [Cat] = []
        for element in 1...5{
            cats.append(Cat(id: "\(element)",
                            name: "\(element)-name",
                            origin: "\(element)-origin",
                            description: "\(element)-description",
                            image: nil,
                            life_span: "") )
        }
        let service = mockCatListingService(cats: cats,
                                            error: nil)
        let sut = CatListViewModel(service: service)
        sut.fetchCatList { _ in
            
        }
        
        if let thirdData = sut.getCatWithPosition(pos: 2){
            XCTAssertEqual(cats[2].id, thirdData.id)
            XCTAssertEqual(cats[2].name, thirdData.name)
            XCTAssertEqual(cats[2].origin, thirdData.origin)
            XCTAssertEqual(cats[2].description, thirdData.description)
        }
    }

}


class mockCatListingService: CatsListingService{
    
    var cats: [CatsApp.Cat]?
    var error: CatsApp.APIError?
    
    init(cats:[CatsApp.Cat]?, error: CatsApp.APIError?){
        self.cats = cats
        self.error = error
    }
    
    func getCats(completionHandler: @escaping ([CatsApp.Cat]?, CatsApp.APIError?) -> ()) {
        completionHandler(cats, error)
    }
    
    func favouriteCatCheck(id: String) -> Bool {
        return false
    }
    
    func removeFavouriteCat(id: String) {
        
    }
    
    func setAsFavourite(cat: CatsApp.Cat) {
        
    }
    
    
}
