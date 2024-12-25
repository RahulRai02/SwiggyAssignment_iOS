//
//  RestaurantDetailView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    var animation: Namespace.ID
    @ObservedObject var vm: HomeViewModel
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        ScrollView {
            restaurantImageAndBackButton
            restaurantInformation
            
            Divider()
                .padding()
            
                
            restaurantMenu
        }
        .toolbar(.hidden)
        .ignoresSafeArea()
    }
}


extension RestaurantDetailView {
    
    // MARK: - Restaurant Image and Back Button
    private var restaurantImageAndBackButton: some View {
        ZStack(alignment:.topLeading){
            
            Image(restaurant.image ?? "placeholder")
                .resizable()
                .scaledToFill()
                .matchedGeometryEffect(id: "\(restaurant.id)", in: animation)
                .ignoresSafeArea()
            
            
            Button {
                withAnimation(.easeIn(duration: 0.34)){
                    isShowingDetailView = false
                }
                
            } label: {
                backButtonLabel()
            }
            .padding(.top, 50)
            .padding(.leading, 20)
        }

    }
    
    // MARK: - Restaurant Information like Name, Rating, Location, Time
    private var restaurantInformation: some View {
        VStack(alignment:.leading, spacing: 0) {
            Text(restaurant.name)
                .font(.title3)
                .fontWeight(.bold)
            HStack(spacing: 2){
                Image(systemName: "star.circle.fill")
                    .matchedGeometryEffect(id: "\(restaurant.id) + star", in: animation)
                
                Text("\(restaurant.rating, specifier: "%.1f")")
                    .matchedGeometryEffect(id: "\(restaurant.id) + restroRating", in: animation)
                
                Text("• 25 mins")
                
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(Color.theme.accent)
            
            Text(restaurant.cuisine.joined(separator: ", "))
                .font(.caption)
            
            
            Text("\(restaurant.location)")
                .font(.caption)
                .matchedGeometryEffect(id: "\(restaurant.id) + restroLocation", in: animation)
        }
        .foregroundStyle(Color.theme.accent)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity, alignment: .center)
    }
        
    // MARK: - Restaurant Menu
    private var restaurantMenu: some View {
        ScrollView{
            ForEach(vm.menus, id: \.self){ menu in
                menuItemCell(menu: menu)
            }
        }
        .onAppear{
            vm.fetchMenus(for: restaurant.id)
        }
    }
    
//    private var menuFilterHeader: some View {
//        HStack(spacing:0){
//            ScrollView(.horizontal) {
//                HStack(spacing: 8){
//                    ForEach(FiltersType.allCases, id: \.self){category in
//                        
//                        CategoryCell(title: category.rawValue.capitalized,
//                                     isSelected: true)
//                    }
//                }
//                .padding(.horizontal, 16)
//            }
//            .scrollIndicators(.hidden)
//            
//        }
//        .padding(.vertical, 24)
//        .padding(.leading, 8)
//        .background(Color.theme.background)
//        
//        
//    }
    
}


