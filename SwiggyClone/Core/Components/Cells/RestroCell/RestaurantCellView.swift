//
//  RestaurantCellView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct RestaurantCellView: View {
    let restaurant: Restaurant
    var animation: Namespace.ID
    var body: some View {
//        NavigationLink {
////            RestaurantDetailView(restaurant: restaurant)
//            AccountScreen()
//        } label: {
            HStack{
    //            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .overlay(
                        
                        Image(restaurant.image ?? "placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 170)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: "\(restaurant.id)", in: animation)
                        )
                    .frame(width: 140, height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                VStack(alignment:.leading) {
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
//                .background(Color.green)

            }
            .frame(height: 160)
            .padding()
//            .background(Color.red)
        }

        

//        .padding(.vertical, 8)
//    }
}

//#Preview {
//    
//    RestaurantCellView(
//        restaurant: Restaurant(
//            id: 1,
//            name: "McDonald's",
//            location: "Gurgaon",
//            rating: 4.3,
//            cuisine: [
//                "American",
//                "Fastfood",
//                "Pasta",
//                "Italien"
//            ],
//            category: "Burgers",
//            image: "burgers"
//        )
//    )
//
//}
