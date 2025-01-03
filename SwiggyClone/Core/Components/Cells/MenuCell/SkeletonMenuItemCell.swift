//
//  SkeletonMenuItemCell.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 03/01/25.
//

import SwiftUI

struct SkeletonMenuItemCell: View {
    var body: some View {
        HStack{
            VStack(alignment:.leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 20)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 20)
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 100)
                
        }
        .padding()
    }
}

#Preview {
    SkeletonMenuItemCell()
}
