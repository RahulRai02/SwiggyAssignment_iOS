//
//  imageCarouselView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

struct imageCarouselView: View {
    @State private var currentPage = 0
    
    var images: [String]
    
//    let images = ["Barista", "BurgerKing", "Chaayos", "greenCravings", "Keventers", "WowMomos"]
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 200)
            .cornerRadius(10)
            .padding([.leading, .trailing], 10)
//            Spacer()
            .onReceive(timer) { _ in
                withAnimation {
                    currentPage = (currentPage + 1) % images.count
                }
            }
        }
    }
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
}

#Preview {
    imageCarouselView(images: ["Barista", "BurgerKing", "Chaayos", "greenCravings", "Keventers", "WowMomos"])
}
