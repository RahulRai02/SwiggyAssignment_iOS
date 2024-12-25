//
//  RestaurantDetailView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    // vm
    @ObservedObject var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss;
    var animation: Namespace.ID
    @Binding var isShowingDetailView: Bool
    
    var body: some View {

        ScrollView {
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
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 15)
                        .padding()
                        .background(.white, in: Circle())
                        .shadow(radius: 5)
                }
                
//                .padding()
                .padding(.top, 50)
                .padding(.leading, 20)
            }
            
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
            
        Divider()
                .padding()
        
            ScrollView{
                ForEach(vm.menus, id: \.self){ menu in
                    menuItemCell(menu: menu)
                }
            }
            .onAppear{
                vm.fetchMenus(for: restaurant.id)
            }
            
            
//            VStack (alignment: .leading, spacing:0) {
////                VStack(alignment:.leading, spacing: 0) {
////                    Text(restaurant.name)
////                        .font(.title3)
////                        .fontWeight(.bold)
////                    HStack(spacing: 2){
////                        Image(systemName: "star.circle.fill")
////                            .matchedGeometryEffect(id: "\(restaurant.id) + star", in: animation)
////                        
////                        Text("\(restaurant.rating, specifier: "%.1f")")
////                            .matchedGeometryEffect(id: "\(restaurant.id) + restroRating", in: animation)
////                        
////                        Text("• 25 mins")
////                        
////                    }
////                    .font(.subheadline)
////                    .fontWeight(.semibold)
////                    .foregroundColor(Color.theme.accent)
////                    
////                    Text(restaurant.cuisine.joined(separator: ", "))
////                        .font(.caption)
////                 
////                        
////                    Text("\(restaurant.location)")
////                        .font(.caption)
////                        .matchedGeometryEffect(id: "\(restaurant.id) + restroLocation", in: animation)
////                }
////            .foregroundStyle(Color.theme.accent)
////            .padding(.horizontal, 8)
////            .frame(maxWidth: .infinity, alignment: .leading)
////            .frame(maxHeight: .infinity, alignment: .center)
//                        
//                        Divider()
//
//                        VStack (alignment: .leading) {
//                            Text("Explore out the menu")
//                                .font(.headline)
//                            
//                            ScrollView() {
//                                ForEach(vm.menus, id: \.self){ menu in
//                                    Text(menu.description)
//                                }
//                            }.scrollTargetBehavior(.paging)
//                            
//                        }.padding(.vertical)
//                    
//                    }
            
//                    .padding()
//                    .frame( alignment: .leading)
//                    .onAppear{
//                        vm.fetchMenus(for: restaurant.id)
//                    }
//                    .background(Color.purple)

                }
                .toolbar(.hidden, for: .tabBar)
                .ignoresSafeArea()

        
        
 
    }
}

//#Preview {
//    RestaurantDetailView(restaurant:      
//        Restaurant(
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
//}

    
//
//struct StretchyHeaderModifier: ViewModifier {
//    var height: CGFloat
//    
//    func body(content: Content) -> some View {
//        GeometryReader { geo in
//            let global = geo.frame(in: .global)
//            
//            content
//                .offset(y: global.minY > 0 ? -global.minY : 0)
//                .frame(height: global.minY > 0 ? height + global.minY : height)
//        }
//        .frame(height: height)
//    }
//}
//
//
//extension View {
//    func stretchyHeader(height: CGFloat) -> some View {
//        self
//            .modifier(StretchyHeaderModifier(height: height))
//    }
//}


