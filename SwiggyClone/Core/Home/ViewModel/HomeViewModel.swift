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
    
    @Published var menus: [MenuMenu] = []
    @Published var categories: [categoryItem] = []
    @Published var isLoadingMenus = false
   
    
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
    
    
    func fetchMenus(for restaurantID: Int){
        menus = []
        
        // If network logic comes, we can add here
        guard let url = Bundle.main.url(forResource: "menuJson", withExtension: "json")
        else{
            print("json file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(MenuResponseByRestroId.self, from: data)
            let restaurantMenus = decodedResponse.menus.first { $0.restaurantID == restaurantID }?.menu ?? []

            self.menus = restaurantMenus
            
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
        
    }
        
    
}
