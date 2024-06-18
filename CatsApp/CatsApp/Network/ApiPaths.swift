//
//  ApiPaths.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

struct APIPath{
    
    private var baseURL:String
    
    init(){
        baseURL = AppEnvironment().baseURL
    }
    
    var getCatsList:String { "\(baseURL)breeds" }
}
