//
//  HomeViewModel.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import Foundation
import SwiftUI
import Combine


class HomeViewModel: ObservableObject {
    @Published var restraunts: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant? = nil
    
    @Published var menus: [MenuMenu] = []
    @Published var categories: [categoryItem] = []  // This is the filter category, dont confuse with food category
   
    
    @Published var frames : [CGRect] = []
    @Published var searchText = ""
    @Published var isRefreshing = false
    @Published var selectedFilter: Category? = Category.all
    @Published var isLoadingRestroMenu = false
    
    
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
//                 print(categoryItem)
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.menus = restaurantMenus
            }
           
            
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
        
    }
        
    func updateRestaurantListBasedOnFilter(selectedFilter: Category){
        // Case statements
        switch selectedFilter {
        case .all:
            fetchRestraunts()
        case .veg:
            // TODO: Filter based on veg
            fetchRestraunts()
        case .rating:
            // Rating greater then 4.5+
//            print(restraunts.filter { $0.rating > 4.5 })
            self.restraunts = restraunts.filter { $0.rating > 4.5 }
            
        case .sortByRating:
            // Sort in accending order
            self.restraunts = restraunts.sorted { $0.rating > $1.rating }
            
        case .bestSeller:
            // TODO: Filter based tag best seller
            fetchRestraunts()
            
        }
    }
    
    
    func resetLists(){
        restraunts = []
        selectedRestaurant = nil
        menus = []
        categories = []
    
    }
    
    func updateRestroBySearchText(searchText: String){
        if searchText.isEmpty {
            fetchRestraunts()
        }else{
            restraunts = restraunts.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.category.lowercased().contains(searchText.lowercased()) }
        }
    }
    

    
}
