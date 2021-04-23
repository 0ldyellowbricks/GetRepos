//
//  SearchBar.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/20/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var textInTextView: String
    @Binding var textNeedToSearch: String
    @State private var searchBarHasText = false
    var body: some View {
        ZStack {
            HStack {
                TextField("", text: $textInTextView)
                    .padding(15)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .onChange(of: textInTextView, perform: { value in
                        if textInTextView != "" {
                            self.textNeedToSearch = textInTextView
                            self.searchBarHasText = true
                        }
                    })
                    .overlay(
                        HStack {
                            if searchBarHasText {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 15)
                                Button(action: {
                                    self.textInTextView = ""
                                    self.searchBarHasText = false
                                }, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                })
                            }
                            
                        }
                    )
            }
            if !self.searchBarHasText {
                BgSearchView()
                    .onTapGesture {
                        self.searchBarHasText = true
                    }
            }
        }
    }
}
 
