//
//  BgSearchView.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/22/21.
//

import SwiftUI

struct BgSearchView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray) 
                .frame(width: 40, height: 40, alignment: .center )
            Text("enter user name")
                .frame(width: 150, height: 40, alignment: .leading) 
                .background(Color(.systemGray6))
                .foregroundColor(.gray)
        }
    }
}

struct BgSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BgSearchView()
    }
}
