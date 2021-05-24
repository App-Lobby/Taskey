//
//  SearchView.swift
//  Taskey
//
//  Created by Mohammad Yasir on 24/05/21.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searched : String
    @Binding var isSearching : Bool
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.8840993866, green: 0.9686274529, blue: 0.9401095322, alpha: 1)).opacity(0.5))
                    .cornerRadius(9)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    TextField("Search ...", text: $searched , onEditingChanged: { (isBegin) in
                        if isBegin {
                            isSearching = true
                        } else {
                            isSearching = false
                        }
                    }).keyboardType(.webSearch)
                    .foregroundColor(.black)
                    
                    if searched != "" {
                        Button(action: {
                            searched = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        }
                        
                    }
                    
                }
                .padding(.trailing , 8)
                .padding(.leading , 12)
                
            }.frame(width: nil, height: 38)
            .padding(.leading, 7)
            .padding(.top , 5)
            .animation(.easeInOut(duration: 0.3))
            
            if isSearching {
                Button(action: {
                    hideKeyboard()
                }) {
                    Text("Cancel")
                }
            }
            
        }
    }
}
