//
//  ReposViewModel.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import Foundation

class ReposViewModel: ObservableObject {
    
    @Published var repos = Repos() 
    var urlStr: String?
    
    init(urlString: String?) {
        self.urlStr = urlString
        requestRepos(description: urlStr ?? "")
    }
     
    func requestRepos(description: String) {
        NetworkManager.shared.getRepos(description: description) { (result) in
            switch result {
            case .success(let repos):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.repos = repos
                     
                }
            case .failure(let error):
                print(error)
            }
        }
    } 
}
