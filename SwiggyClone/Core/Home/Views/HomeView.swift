//
//  HomeView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//


import SwiftUI
import Foundation

struct HomeView: View {

    @State var isShowingDetailView = false
    @Namespace var animation

    @StateObject private var vm: HomeViewModel = HomeViewModel()

    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                ScrollView{
                    navigationHeader
                    
                    searchBarHeader
                        .sticky(vm.frames)
                    
                    imageCarouselView(
                        images: [
                            "Barista",
                            "BurgerKing",
                            "Chaayos",
                            "greenCravings",
                            "Keventers",
                            "WowMomos"
                        ]
                    )
                    
                    
                    foodCategoryHeading
                    foodCategoryContent
                    
                    imageCarouselView(
                        images: [
                            "Barista",
                            "BurgerKing",
                            "Chaayos",
                            "greenCravings",
                            "Keventers",
                            "WowMomos"
                        ].reversed()
                    )
                    
                    filterHeader
                        .sticky(vm.frames)
                    
                    
                    
                    verticalRestrauntContentHeading
                    verticalRestrauntContent
                }
                
                .refreshable(action: {
                    await refreshData()
                })
                .coordinateSpace(name: "container")
                
                .onPreferenceChange(FramePreferenceKey.self, perform: {
                    vm.frames = $0.sorted(by: { $0.minY < $1.minY })
                })
                
                /*
                 .overlay(alignment: .center){
                 let str = frames.map{
                 "\(Int($0.minY)) - \(Int($0.height))"
                 }.joined(separator: "\n")
                 Text(str)
                 .foregroundColor(.white)
                 .background(.black)
                 
                 }
                 */
                .clipped()
                
                .disabled(isShowingDetailView)
            }
            .blur(radius: isShowingDetailView ? 100 : 0)
            if isShowingDetailView {
                RestaurantDetailView(restaurant: vm.selectedRestaurant!, animation: animation, vm: vm, isShowingDetailView: $isShowingDetailView)
            }
        }
    }
    
    // MARK: - Refresh whole page data
    func refreshData() async {
        vm.isRefreshing = true
        vm.resetLists()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            vm.fetchCategories()
            vm.fetchRestraunts()
        }
        vm.isRefreshing = false
    }

}


// MARK: - Extension on HomeView
extension HomeView {
    // MARK: - Navigation Header
    private var navigationHeader: some View {
        HStack{
            VStack(alignment:.leading){
                HStack{
                    Image(systemName: "house.fill")
                        .foregroundColor(Color.theme.orangeCol)
                    Text("Home")
                        .font(.headline)
                        .foregroundStyle(Color.theme.accent)
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color.theme.accent)
                }
                Text("134 Sector 28, Gurugram")
                    .foregroundStyle(Color.theme.accent)
            }
            .padding()
            Spacer()
            NavigationLink {
                AccountScreen()
            } label: {
                Image(systemName: "person.circle")
                    .padding()
                    .font(.system(size: 32))
                    .foregroundStyle(Color.theme.accent)
                
            }
        }
        //        .background(Color.red)
    }
    
    // MARK: - Search Bar
    private var searchBarHeader: some View {
        SearchBarView(searchText: $vm.searchText)
            .onChange(of: vm.searchText) { oldValue, newValue in
                withAnimation(.easeInOut){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        vm.updateRestroBySearchText(searchText: newValue)
                    }
                }
            }
            
    }
    
    // MARK: - Food Category Heading
    private var foodCategoryHeading: some View {
        Text("WHAT'S ON YOUR MIND?")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 8)
    }
    
    // MARK: - Food Category Content
    private var foodCategoryContent: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHGrid(rows: [GridItem(.flexible(), spacing: 10, alignment: nil),
                             GridItem(.flexible(), spacing: 10, alignment: nil)], alignment: .top ) {
                if vm.categories.isEmpty {
                    SkeletonCategoryCellView()
                } else {
                    // Show actual food categories
                    ForEach(vm.categories, id: \.self) { category in
                        NavigationLink {
                            //Todo: Navigate to category based restraurants
                            
                        } label: {
                            FoodCategoryCell(image: category.image, name: category.name)
                        }
                    }
                }
                
                
            }
             .onAppear{
                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     vm.fetchCategories()
                 }
             }

             .padding()
        }
    }

    
    // MARK: - Vertical Restraunt Content Heading
    private var verticalRestrauntContentHeading: some View {
        Text("Top 10 restraurants to explore")
            .font(.callout)
            .fontWeight(.bold)
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 8)
    }
    
    // MARK: - Vertical Restraunt Content
    private var verticalRestrauntContent: some View {
        ScrollView{
            VStack(spacing: 2) {
                if vm.restraunts.isEmpty {
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonRestaurantCellView()
                    }
                }else{
                    ForEach(vm.restraunts, id: \.id){ restaurant in
                        if !isShowingDetailView{
                            RestaurantCellView(restaurant: restaurant, animation: animation)
                                .onTapGesture {
                                    print("Tapped restro cell")
                                    withAnimation(.easeIn(duration: 0.34)){
                                        vm.selectedRestaurant = restaurant
                                        isShowingDetailView = true
                                    }
                                    
                                }
                        }

                    }
                }
                
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    vm.fetchRestraunts()
                }
            }
        }
    }
    
    // MARK: - Filter Header
    private var filterHeader: some View {
        HStack(spacing:0){
            ScrollView(.horizontal) {
                HStack(spacing: 8){
                    ForEach(Category.allCases, id: \.self){category in
                        
                        CategoryCell(title: category.rawValue.capitalized,
                                     isSelected: category == vm.selectedFilter)
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                vm.selectedFilter = category
                                vm.updateRestaurantListBasedOnFilter(selectedFilter: category)
                            }
                            
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.theme.background)
    }
    
}




// MARK: - Preview
#Preview {
    HomeView()
}
