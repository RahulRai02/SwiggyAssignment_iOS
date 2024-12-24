//
//  Menu.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import Foundation

import Foundation

// MARK: - Welcome
struct MenuResponseByRestroId: Codable {
    let menus: [WelcomeMenu]
}

// MARK: - WelcomeMenu
struct WelcomeMenu: Codable {
    let restaurantID: Int
    let menu: [MenuMenu]

    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case menu
    }
}

// MARK: - MenuMenu
struct MenuMenu: Codable {
    let id: Int
    let name, description: String
    let price: Int
    let category: String
    let image: String
}


