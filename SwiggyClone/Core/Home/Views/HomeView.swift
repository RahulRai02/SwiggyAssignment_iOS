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

struct HomeView: View {
    @State private var frames : [CGRect] = []
    @State private var searchText = ""
    @State private var isRefreshing = false
    @State private var selectedCateogry: Category? = nil
    
    var stickyHeaderIsPinned: Bool {
        frames.first?.minY ?? 0 <= 0
    }

    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                ScrollView{
                    HStack{
                        VStack(alignment:.leading){
                            HStack{
                                Image(systemName: "house")
                                    .foregroundColor(Color.theme.orange)
                                Text("Home")
                                    .font(.headline)
                                Image(systemName: "chevron.down")
                            }
                            Text("134 Sector 28, Gurugram")
                        }
                        .padding()
                        Spacer()
                        Image(systemName: "person.circle")
                            .padding()
                            .font(.system(size: 32))
                    }
                    SearchBarView(searchText: $searchText)
                        .sticky(frames)
                        .safeAreaPadding(.init( top: 0, leading: 8, bottom: 0, trailing: 8))
                    dummyContent
                    
                    header
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
                .overlay(alignment: .center){
                    let str = frames.map{
                        "\(Int($0.minY)) - \(Int($0.height))"
                    }.joined(separator: "\n")
                    Text(str)
                        .foregroundColor(.white)
                        .background(.black)

                }
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
    
    private var header: some View {
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
