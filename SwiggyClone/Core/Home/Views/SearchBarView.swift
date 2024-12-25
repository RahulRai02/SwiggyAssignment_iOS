//
//  SearchBarView.swift
//  SwiggyClone
//
//  Created by Rahul Rai on 24/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            TextField("Search by item or dish", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
//                        .background(Color.red)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            
        }
        
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                
                .fill(Color.white)
                .strokeBorder(style: StrokeStyle(lineWidth: 0.5))

        )
        .background(Color.white)
//        .padding()
        .safeAreaPadding(.init(top: 0, leading: 8, bottom: 20, trailing: 8))

    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}



// Made this extension in order to dismiss the keyboard when we click on the clear button ....

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
