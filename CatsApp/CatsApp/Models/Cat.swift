//
//  Cat.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import Foundation

struct Cat: Codable {
    let id: String
    let name: String
    let origin: String
    let description: String
    let image: CatImage?
    let life_span: String
}
