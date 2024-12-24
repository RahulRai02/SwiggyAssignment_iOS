//
//  Color.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let orange = Color("OrangeColor")
    let secondaryText = Color("SecondaryTextColor")
}
