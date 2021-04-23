//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import Foundation
let clientId = "c1276f3de8ce7b68c8e5", clientSecret = "e75e61658e9e0ac711750c838840b0f1724381dc"
let githubRateLimit = "client_id=\(clientId)&client_secret=\(clientSecret)"
let githubToken = "access_token=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"
//https://api.github.com/rate_limit?access_token=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
enum NetworkError: LocalizedError {
    case response
    case data
    case decoding
    case invalidURL
    case notFound
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .response:
            return "Something went wrong. Please try again"
        case .data:
            return "There was a problem with your request. Please try again"
        case .decoding:
            return "Something went wrong. Please try again"
        case .invalidURL:
            return "Sorry we couldn't find anything. Please try a different search search phrase"
        case .notFound:
            return "Sorry we couldn't find what you're looking for"
        case .serverError:
            return "Something went wrong please try again"
        }
    }
}


enum UserSearchEndPoint {
    case getUsers(description: String, page: String)
    case getRepos(description: String)
    
    var path: String {
        switch self {
        case .getUsers(description: let description, page: let page):
            return "search/users?\(githubRateLimit)&q=\(description)&per_page=10&page=\(page)"
//            return "search/users?q=\(description)&per_page=10&page=\(page)"
        case .getRepos(description: let description):
            return "users/\(description)?\(githubToken)"
//            return "users/\(description)"
        }
    }
    
    var url: URL? {
        let scheme = "https://"
        let domain = "api.github.com/"
        
        switch self {
        case .getUsers(description: _, page: _):
            return URL(string: "\(scheme)\(domain)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        case .getRepos(description: _):
            return URL(string: "\(scheme)\(domain)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    func getUsers(description: String, page: String, completed: @escaping (Result<[UserInfo], NetworkError>) -> Void) {
        guard let url = UserSearchEndPoint.getUsers(description: description, page: page).url else {
            completed(.failure(.invalidURL))
            return
        }
        print("getUsersurl---",url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.serverError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.response))
                return
            }
            guard let data = data else {
                completed(.failure(.data))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Feed.self, from: data)
                completed(.success(result.items))
            } catch {
                completed(.failure(.decoding)) 
            }
        }
        task.resume()
    }
     
    func getRepos(description: String, completed: @escaping (Result<Repos, NetworkError>) -> Void) {
        guard let url = UserSearchEndPoint.getRepos(description: description).url else {
            completed(.failure(.invalidURL))
            return
        }
//        print("getReposurl---",url)
         
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.serverError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.response))
                return
            }
            guard let data = data else {
                completed(.failure(.data))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Repos.self, from: data) 
                completed(.success(result))
            } catch {
                completed(.failure(.decoding))
                print(error)
            }
        }
        task.resume()
    }
    
    
}
