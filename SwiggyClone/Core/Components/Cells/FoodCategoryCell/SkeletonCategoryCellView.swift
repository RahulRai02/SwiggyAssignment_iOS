//
//  SkeletonCategoryCellView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct SkeletonCategoryCellView: View {
    var body: some View {
        ForEach(0..<10, id: \.self) { _ in
            VStack(alignment: .center) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 75, height: 75)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .shadow(radius: 5)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 75, height: 15)
            }
        }
    }
}

#Preview {
    SkeletonCategoryCellView()
}
