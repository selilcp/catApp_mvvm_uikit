//
//  APILoader.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

class APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(urlParam urls: [String: String]? ,
                        queryParam query: [String: String]? ,
                        bodyParam body: [String: Any]?,
                        completionHandler: @escaping (T.ResponseDataType?, APIError?) -> ()) {
        
        if let urlRequest = apiHandler.makeRequest(urlParam: urls,
                                                   queryParam: query,
                                                   bodyParam: body) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                let errorMessage = error?.localizedDescription
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil, let responseData = data else {
                        completionHandler(nil, APIError(errorCode: httpResponse.statusCode,
                                                        message: errorMessage))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData,
                                                                               response: httpResponse)
                        completionHandler(parsedResponse, nil)
                    } catch {
                        completionHandler(nil, APIError(errorCode:  httpResponse.statusCode,
                                                        message: errorMessage))
                    }
                    
                }else if let message = errorMessage,
                         message.lowercased().contains("internet connection appears to be offline"){
                    completionHandler(nil, APIError(errorCode: 0,
                                                    message: message))
                }else{
                    completionHandler(nil, APIError(errorCode: 1,
                                                    message: errorMessage))
                }

            }.resume()
        }
    }
}
