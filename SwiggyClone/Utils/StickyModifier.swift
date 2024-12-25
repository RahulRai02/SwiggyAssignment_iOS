//
//  StickyModifier.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 25/12/24.
//

import Foundation
import SwiftUI


struct Sticky: ViewModifier{
    var stickyRects: [CGRect]
    @State var frame: CGRect = .zero
    
    var isSticking: Bool {
        frame.minY < 0
    }
    
    var offset: CGFloat {
        guard isSticking else { return 0 }
        var o = -frame.minY
        if let idx = stickyRects.firstIndex(where: { $0.minY > frame.minY && $0.minY < frame.height }) {
            let other = stickyRects[idx]
            o -= frame.height - other.minY
        }
        return o
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .zIndex(isSticking ? .infinity : 0)
        
            .overlay {
                GeometryReader{ proxy in
                    let f = proxy.frame(in: .named("container"))
                    Color.clear
                        .onAppear{
                            frame = f
                        }
                        .onChange(of: f) {
                            frame = $0
                        }
                        .preference(key: FramePreferenceKey.self, value: [frame])
                    
                }
            }
        
    }
}

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: [CGRect] = []
    
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
    
}

extension View {
    func sticky(_ stickyRects: [CGRect]) -> some View {
        self
            .modifier(Sticky(stickyRects: stickyRects))
    }
}

