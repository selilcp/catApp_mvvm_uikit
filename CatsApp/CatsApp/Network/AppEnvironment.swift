//
//  AppEnvironment.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

struct AppEnvironment {
    
    static let shared = AppEnvironment()
    
    var baseURL:String { "https://api.thecatapi.com/v1/" }
    var xApiKey:String { "live_diCQpe5cQkq1TMZccyNdpCDVkrNaYcKUOi0cwZbAfIeR8QRQo5fN68qiPLwL6IdJ" }
}
