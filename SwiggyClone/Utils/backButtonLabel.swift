//
//  backButtonLabel.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import SwiftUI

struct backButtonLabel: View {
    var body: some View {
        Image(systemName: "chevron.left")
            .resizable()
            .scaledToFit()
            .frame(width: 10, height: 15)
            .padding()
            .background(.white, in: Circle())
            .shadow(radius: 5)
    }
}

#Preview {
    backButtonLabel()
}
