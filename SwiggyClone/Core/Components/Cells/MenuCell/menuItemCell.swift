//
//  menuItemCell.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct menuItemCell: View {
    var menu: MenuMenu
    
    var body: some View {
        HStack{
            VStack(alignment:.leading, spacing: 0) {
                Text(menu.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Rs \(menu.price)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.accent)
                
                Text("\(menu.description)")
                    .font(.caption)
                    .fontWeight(.light)
            }
            .foregroundStyle(Color.theme.accent)
            

            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .overlay(
                    Image(menu.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                    
                    )
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
        }
        .padding()
//        .background(Color.red)
    }
}

#Preview {
    menuItemCell(menu: MenuMenu(id: 1, name: "Choco lava Cake", description: "Chocolate lovers delight ! Indeugetn, gooey molten lave insuide chocolate cake", price: 99, category: "cake", image: "burgers"))
}
