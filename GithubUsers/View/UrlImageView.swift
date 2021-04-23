//
//  UrlImageView.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultImage = UIImage(named: "NewsIcon")
    init(urlStr: String?) {
        urlImageModel = UrlImageModel(urlString: urlStr)
    }
    var body: some View { 
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .cornerRadius(10)
            .scaledToFit()
            .frame(width: 60, height: 60)
            .padding([.top, .bottom], 10)
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(urlStr: nil)
    }
}
