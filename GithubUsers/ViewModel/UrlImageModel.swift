//
//  UrlImageModel.swift
//  GithubUsers
//
//  Created by Jing Zhao on 4/21/21.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlStr: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String?) {
        self.urlStr = urlString
        loadImage()
    }
    func loadImage() {
        if loadImageFromCache() {
            print("ccccache hiiit")
            return
        }
//        print("cacheee miss, load from url")
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlStr else {
            return false
        }
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl() {
        guard let urlstring = urlStr else {
            return
        }
        let url = URL(string: urlstring)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:reponse:error:))
        task.resume()
    }
    func getImageFromResponse(data: Data?, reponse: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlStr!, image: loadedImage)
            self.image = loadedImage
        }
    }
}
class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
