//
//  APIHandler.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol APIHandler {
    associatedtype ResponseDataType
    func makeRequest(urlParam urls: [String: String]?,
                     queryParam query: [String: String]?,
                     bodyParam body: [String: Any]?) -> URLRequest?
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

extension APIHandler {
    func setQueryParams(parameters:[String: String], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    
    func setDefaultHeaders(request: inout URLRequest) {
        setJSONContentTypeHeader(request: &request)
        setApiKey(request: &request,
                  apiKey: AppEnvironment.shared.xApiKey)
    }
    
    func setJSONContentTypeHeader(request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func setApiKey(request: inout URLRequest, apiKey:String) {
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
    }
    
    func updateURL(url: inout String, replacemetValues: [String: String]) {
        replacemetValues.forEach { url = url.replacingOccurrences(of: "{\($0.key)}", with: $0.value) }
    }
    
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            switch response.statusCode{
            case 200..<300:
                return body
            default:
                throw APIError(errorCode: response.statusCode, message: nil)
            }
        } catch  {
            throw APIError(errorCode: response.statusCode, message: nil)
        }
        
    }
}
