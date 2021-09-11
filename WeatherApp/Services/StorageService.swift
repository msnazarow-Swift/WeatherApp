//
//  StorageService.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit
class StorageService: NSObject {
    static let shared = StorageService()
    var images: [String: UIImage] = [:]

    func saveImages(_ images: [String: UIImage]) {
        self.images = images
    }

    func getImageForKey(_ key: String) -> UIImage? {
        return images[key]
    }
}
