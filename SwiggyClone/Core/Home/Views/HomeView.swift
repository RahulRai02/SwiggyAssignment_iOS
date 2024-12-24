//
//  HomeView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

enum Category : String, CaseIterable{
//    case all, music, podcasts, audiobooks
    case Filter, SortBy, FastDelivery, Offers, Rating, CostForTwo, More
}

enum TabWidget: String, CaseIterable{
    case whatsNew = "What's New?"
    case popular = "Popular"
    case gourmetDelights = "Gourmet Delights"
}

struct HomeView: View {
    @State private var frames : [CGRect] = []
    @State private var searchText = ""
    @State private var isRefreshing = false
    @State private var selectedCateogry: Category? = nil
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    var stickyHeaderIsPinned: Bool {
        frames.first?.minY ?? 0 <= 0
    }

    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                ScrollView{
                    
                    navigationHeader
                    searchBarHeader
                        .sticky(frames)
 
                    imageCarouselView()
                    
                    ScrollView(.horizontal, showsIndicators: false){
//                        Text("Placeholder")
                        LazyHGrid(rows: [GridItem(.flexible(), spacing: 12, alignment: nil),
                                         GridItem(.flexible(), spacing: 12, alignment: nil)], alignment: .top ) {
                            
                            ForEach(vm.categories, id: \.self){ category in
                                Text(category)
                                    .foregroundStyle(Color.black)
                            }
                        
                        }
                                         .onAppear{
                                                vm.fetchRestraunts()
                                             vm.fetchCategories()
                                         }
                                         
                                         .padding()
                    }

                    
                    dummyContent
                    
                    filterHeader
                        .sticky(frames)

                    dummyContent
                        
                      
                }
                .refreshable(action: {
                    await refreshData()
                })
                .coordinateSpace(name: "container")
                .onPreferenceChange(FramePreferenceKey.self, perform: {
                    frames = $0.sorted(by: { $0.minY < $1.minY })
                })
//                .overlay(alignment: .center){
//                    let str = frames.map{
//                        "\(Int($0.minY)) - \(Int($0.height))"
//                    }.joined(separator: "\n")
//                    Text(str)
//                        .foregroundColor(.white)
//                        .background(.black)
//
//                }
                .clipped()
            }
        }

            
    }
    func refreshData() async {
        isRefreshing = true
        // Simulate a network delay
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        isRefreshing = false
    }
    
    private var filterHeader: some View {
        HStack(spacing:0){
            ScrollView(.horizontal) {
                HStack(spacing: 8){
                    ForEach(Category.allCases, id: \.self){category in
                
                        CategoryCell(title: category.rawValue.capitalized,
                                            isSelected: category == selectedCateogry)
                        .onTapGesture {
                            selectedCateogry = category
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
  
    private var dummyContent: some View {
        ForEach(0..<8){ i in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .frame(height: 200)
                .padding()
        }
    }
            
    
}

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: [CGRect] = []
    
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
    
}


struct Sticky: ViewModifier{
    var stickyRects: [CGRect]
    @State var frame: CGRect = .zero
    
    var isSticking: Bool {
        frame.minY < 0
    }
        
    var offset: CGFloat {
        guard isSticking else { return 0 }
        var o = -frame.minY
        if let idx = stickyRects.firstIndex(where: { $0.minY > frame.minY && $0.minY < frame.height }) {
            let other = stickyRects[idx]
            o -= frame.height - other.minY
        }
        return o
    }
    
    func body(content: Content) -> some View {
        content
//            .background(Color.white.ignoresSafeArea())
            
            .offset(y: offset)
            .zIndex(isSticking ? .infinity : 0)
            
            .overlay {
                GeometryReader{ proxy in
                    let f = proxy.frame(in: .named("container"))
//                    f.minY < 0 ? Color.red : Color.green
                    Color.clear
                        .onAppear{
                            frame = f
                        }
                        .onChange(of: f) {
                            frame = $0
                        }
                        .preference(key: FramePreferenceKey.self, value: [frame])
                    
                }
            }
            
    }
}

extension View {
    func sticky(_ stickyRects: [CGRect]) -> some View {
        self
            .modifier(Sticky(stickyRects: stickyRects))
    }
}

#Preview {
    HomeView()
//        .ignoresSafeArea(/*@START_MENU_TOKEN@*/.keyboard/*@END_MENU_TOKEN@*/, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
}


extension HomeView {
    private var navigationHeader: some View {
        HStack{
            VStack(alignment:.leading){
                HStack{
                    Image(systemName: "house.fill")
                        .foregroundColor(Color.theme.orange)
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
    private var searchBarHeader: some View {
        SearchBarView(searchText: $searchText)
            
//            .safeAreaPadding(.init( top: 0, leading: 8, bottom: 4, trailing: 8))
    }
    
}


