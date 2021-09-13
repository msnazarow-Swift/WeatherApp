//
//  ImageStorageService.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class ImageStorageService: ImageStorageServiceProtocol {
    // MARK: - Properties
    var images: [String: UIImage] = [:]
    let abbreviations = ["sn", "sl", "h", "t", "hr", "lr", "s", "hc", "lc", "c"]

    // MARK: - Methods
    func saveImages(_ images: [String: UIImage]) {
        self.images = images
    }

    func saveImage(for arrb: String, image: UIImage?) {
        self.images[arrb] = image
    }

    func getImage(for abbr: String) -> UIImage? {
        return images[abbr]
    }
}
