//
//  CatListHandler.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

class CatListHandler: APIHandler {
    
    func makeRequest(urlParam urls: [String: String]?,
                     queryParam query: [String : String]?,
                     bodyParam body: [String : Any]?) -> URLRequest? {
        
        let urlString =  APIPath().getCatsList
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [Cat] {
        return try defaultParseResponse(data: data, response: response)
    }
}
