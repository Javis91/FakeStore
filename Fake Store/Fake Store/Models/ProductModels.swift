//
//  ProductModels.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

struct Product: Codable{
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: ProductRating?
}

struct ProductRating: Codable{
    let rate: Double?
    let count: Int
}
