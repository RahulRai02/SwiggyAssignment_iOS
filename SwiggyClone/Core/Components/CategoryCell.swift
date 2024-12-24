//
//  CategoryCell.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

struct CategoryCell: View {
    var title: String = "Filter"
    var isSelected: Bool = false
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)

            .background(isSelected ? Color.theme.orange : Color.white)
            .foregroundStyle(isSelected ? Color.white : Color.black)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: isSelected ? 0 : 0.7)
            )
    }
}

#Preview {
    ZStack{
        Color.white.ignoresSafeArea()
        VStack(spacing: 40){
            CategoryCell(title: "Title goes here")
            CategoryCell(title: "Title goes here", isSelected: true)
            CategoryCell(isSelected: false)
        }
       
    }
    
}
