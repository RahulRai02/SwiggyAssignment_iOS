//
//  ContentView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI
// NOT THE ENTRY POINT OF THE APP
struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 40){
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Orange Color")
                    .foregroundColor(Color.theme.orangeCol)                
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
