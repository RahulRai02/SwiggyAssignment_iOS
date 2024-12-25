//
//  FoodCategoryCell.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct FoodCategoryCell: View {
    var image: String = "burgers"
    var name: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 5)
            
            Text(name)
                .font(.caption)
                .lineLimit(1)
        }
    }
}

#Preview {
    FoodCategoryCell(name: "Burger")
}
