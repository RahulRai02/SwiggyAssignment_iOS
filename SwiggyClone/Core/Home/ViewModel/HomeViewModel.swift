//
//  HomeViewModel.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import Foundation
import SwiftUI


class HomeViewModel: ObservableObject {
    @Published var restraunts: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant? = nil
    
    @Published var menus: [WelcomeMenu] = []
    @Published var categories: [categoryItem] = []
   
    
    func fetchRestraunts(){
        // If network logic comes, we can add here
        guard let url = Bundle.main.url(forResource: "restroMockJson", withExtension: "json")
            else{
                print("restro json file not found")
                return
            }
     
        do {
            let data = try Data(contentsOf: url)
            let restroResponse = try JSONDecoder().decode(RestaurantResponse.self, from: data)
            
            self.restraunts = restroResponse.restaurants
            
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    
    func fetchCategories(){
        // If network logic comes, we can add here
        guard let url = Bundle.main.url(forResource: "restroMockJson", withExtension: "json")
            else{
                print("menujson file not found")
                return
            }
            
        do {
            let data = try Data(contentsOf: url)
            let restroResponse = try JSONDecoder().decode(RestaurantResponse.self, from: data)

                    
            var categoryList: [categoryItem] = []
         
            for item in restroResponse.restaurants {
                let categoryItem = categoryItem(name: item.category, image: item.image ?? "placeholder")
                categoryList.append(categoryItem)
                 print(categoryItem)
            }

            self.categories = categoryList
            
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    
    
    }
    
    
//    func fetchMenus(for restaurantID: Int){
//        // If network logic comes, we can add here
//        guard let url = Bundle.main.url(forResource: "menuMockJson", withExtension: "json")
//        else{
//            print("json file not found")
//            return
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let menuResponse = try JSONDecoder().decode(MenuResponseByRestroId.self, from: data)
//            
//            let filteredMenus = menuResponse.menus.filter({ $0.restaurantID == restaurantID })
//            self.menus = filteredMenus
//            
//            var categorySet: Set<String> = []
//                    
//            // Extract categories from each menu item
//            for menu in filteredMenus {
//                for item in menu.menu {
//                    categorySet.insert(item.category)
//                }
//            }
//            
//            // Convert the Set to an array and assign it to categories
//            self.categories = Array(categorySet).sorted()
//            
//        } catch {
//            print("Failed to decode JSON: \(error.localizedDescription)")
//        }
//        
//    }
        
    
}
