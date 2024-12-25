//
//  SkeletonRestaurantCellView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct SkeletonRestaurantCellView: View {
    var body: some View {
        HStack {
            // Placeholder for the image
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 140, height: 170)

            VStack(alignment: .leading, spacing: 8) {
                // Placeholder for the title
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 20)

                // Placeholder for the rating and time
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 15)

                // Placeholder for the cuisine
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 180, height: 15)

                // Placeholder for the location
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 15)
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 160)
        .padding()
    }
}


#Preview {
    SkeletonRestaurantCellView()
}
