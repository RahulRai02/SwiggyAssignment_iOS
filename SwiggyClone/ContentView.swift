//
//  ContentView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 40){
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Orange Color")
                    .foregroundColor(Color.theme.orange)                
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
