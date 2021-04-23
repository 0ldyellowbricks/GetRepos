//
//  ReposTextView.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import SwiftUI

struct ReposTextView: View {
    @ObservedObject var reposModel: ReposViewModel
    init(userName: String?) {
        reposModel = ReposViewModel(urlString: userName)
    }
    
    
    var body: some View {
        Text("Number of repos: \(reposModel.repos.public_repos ?? 0)")
            .foregroundColor(Color(UIColor.gray))
            .font(.subheadline)
            .padding(.bottom, 1.0)
        
    }
}

struct ReposTextView_Previews: PreviewProvider {
    static var previews: some View { 
        ReposTextView(userName: nil)
    }
}
