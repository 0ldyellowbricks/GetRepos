//
//  UserViewModel.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var users = [UserInfo]()
    var lastUserLogin = ""
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    
    
    init() {}
    
    subscript(position: Int) -> UserInfo {
        return users[position]
    }
    
    func getUsersData(description: String, searchTxt: String, firsPage: Int, currentItem: UserInfo?) {
        print("firsPage ---", firsPage, "--description-",description, "--searchTxt--", searchTxt, "--currentItem--", currentItem?.login ?? "")
        if firsPage == 1 {
            loadStatus = LoadStatus.ready(nextPage: 1)
        }
 
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        
        loadStatus = .loading(page: page)
        let updatePage = "\(page)"
        
        NetworkManager.shared.getUsers(description: description, page: updatePage) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if firsPage == 1 {
                        self.users = []
                    }
                    self.users += user
                    self.lastUserLogin = self.users.last?.login ?? ""
                    if self.users.count == 0 {
                        self.loadStatus = .done
                    } else {
                        self.loadStatus = .ready(nextPage: page + 1)
                    }
                }
            case .failure(let error):
                self.loadStatus = .parseError
                print(error)
            }
        }
        
        
        
        
         
 
    }
    
    
    
      
    
    
    
    func shouldLoadMoreData(currentItem: UserInfo? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        if users.count < 10 {
            return false
        } 
        if currentItem.login == users.last?.login {
            return true
        }
        return false
    }
    
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}
