//
//  ContentView.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/20/21.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    
    @State var textInSearchBar = ""
    @State var textNeedToSearch = ""
    var isScrollDown = true
    
    let gridItem = GridItem(.flexible(minimum: 300, maximum: .infinity), alignment: .leading)
    
    var body: some View {
        NavigationView { 
            VStack {
                SearchBar(textInTextView: $textInSearchBar, textNeedToSearch: $textNeedToSearch)
                    .onChange(of: textNeedToSearch, perform: { value in
                        let userItem: UserInfo? = nil
                        
                        self.viewModel.getUsersData(description: textInSearchBar, searchTxt: textNeedToSearch, firsPage: 1, currentItem: userItem)
                    })
                ScrollView {
                    LazyVGrid(columns: [gridItem]) { 
                        ForEach(viewModel.users, id: \.self) { user in
                            UserView(ghUser: user)
                                
                                .onAppear(perform: {
                                    if self.viewModel.lastUserLogin == user.login {
                                        self.viewModel.getUsersData(description: textInSearchBar, searchTxt: textNeedToSearch, firsPage: 0, currentItem: user)
                                    } 
                                })
                                .id("user.login--\(String(describing: user.login))")
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            .navigationBarTitle("Github Repos", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
