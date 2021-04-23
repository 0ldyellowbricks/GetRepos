//
//  UserView.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import SwiftUI

struct UserView: View { 
    let ghUser: UserInfo
    
    var body: some View {
        HStack(alignment: .center) {
            UrlImageView(urlStr: ghUser.avatar_url)
            Spacer()
                .frame(width: 10, height: 2, alignment: .leading)
            VStack(alignment: .leading) {
                Text(ghUser.login ?? "")
                    .foregroundColor(Color(UIColor.label))
                    .lineLimit(2)
                    .font(.headline)
                    .padding([.top, .bottom], 1)
                ReposTextView(userName: ghUser.login)
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(ghUser: UserInfo(login: "test", avatar_url: "test12", repos_url: "test123"))
    }
}
