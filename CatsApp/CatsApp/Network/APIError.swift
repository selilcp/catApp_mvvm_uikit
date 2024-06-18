//
//  APIError.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

enum NetworkError:Int{
    case noInternet = 0
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyRequest = 429
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case timedOut = 504
    case other = 1
}

struct APIError:Error,Identifiable{
    
    private var errorMessage:String?
    var id: Int
    var networkError:NetworkError
    
    init(errorCode:Int,message:String?){
        errorMessage = message
        networkError = NetworkError(rawValue: errorCode) ?? .other
        id = networkError.rawValue
    }
    
    var alertMessage: String {
        switch networkError{
        case .noInternet : return "No internet"
        case .internalServerError : return "Internal server error"
        case .timedOut: return "Time out"
        case .serviceUnavailable: return "Service unavailable"
        case .unauthorized: return "UnAuthorized access"
        default: return "Something went wrong, please try again later"
        }
    }
}
