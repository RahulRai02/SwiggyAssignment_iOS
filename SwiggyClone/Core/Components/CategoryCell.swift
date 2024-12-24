//
//  CategoryCell.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

struct CategoryCell: View {
    var title: String = "Music"
    var isSelected: Bool = false
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
//            .background(isSelected ? .spotifyGreen : .spotifyDarkGrey)
//            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .cornerRadius(16)
    }
}

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? Color.theme.orange : Color.white)
            .foregroundStyle(isSelected ? Color.white : Color.black)
    }
}


#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        VStack(spacing: 40){
            CategoryCell(title: "Title goes here")
            CategoryCell(title: "Title goes here", isSelected: true)
            CategoryCell(isSelected: false)
        }
       
    }
    
}
