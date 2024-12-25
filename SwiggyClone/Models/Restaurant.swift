//
//  Restaurant.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import Foundation

// MARK: - Welcome
struct RestaurantResponse: Codable {
    var restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable {
    var id: Int
    var name, location: String
    var rating: Double
    var cuisine: [String]
    var category: String
    var image: String?
}

struct categoryItem: Identifiable, Hashable{
    var id = UUID()
    var name: String
    var image: String
}
