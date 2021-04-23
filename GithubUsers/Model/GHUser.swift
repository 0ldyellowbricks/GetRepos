//
//  GHUser.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import Foundation

struct Feed: Codable {
    var items: [UserInfo]
}

struct UserInfo: Codable, Hashable {
    var node_id: String?
    var login: String? 
    var avatar_url: String?
    var repos_url: String?
}
struct Repos: Codable {
    var login: String?
    var public_repos: Int?
    var node_id: String?
}
