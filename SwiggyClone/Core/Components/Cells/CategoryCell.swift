//
//  CategoryCell.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

// MARK: - UI Component for filter cells

struct CategoryCell: View {
    var title: String = "Filter"
    var isSelected: Bool = false
    var body: some View {
        Text(title)
            .font(.callout)
            .fontWeight(.semibold)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)

            .background(isSelected ? Color.theme.orangeCol : Color.white)
            .foregroundStyle(isSelected ? Color.white : Color.black.opacity(0.7))
//            .fontweight(.semibold)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.theme.secondaryText, lineWidth: isSelected ? 0 : 0.7)
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
