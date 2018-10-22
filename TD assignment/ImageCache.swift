//
//  ImageCache.swift
//  TD assignment
//
//  Created by Sacha Sukhdeo on 2018-10-22.
//  Copyright © 2018 Sacha Sukhdeo. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    static var imageCache: Dictionary<URL, UIImage> = [:]
    static private var urlCache: Array<URL> = []
    static private let maxCacheSize = 20
    
    static func add(image: UIImage, url: URL) {
        
        if imageCache[url] != nil {
            return
        }
        
        imageCache[url] = image
        urlCache.append(url)
        cleanUpCache()
    }
    
    static func get(imageWithURL url: URL) -> UIImage? {
        return imageCache[url]
    }
    
    private static func cleanUpCache() {
        if imageCache.count > maxCacheSize,
            let url = urlCache.first {
            imageCache.removeValue(forKey: url)
            urlCache.removeFirst()
        }
    }
    
}
