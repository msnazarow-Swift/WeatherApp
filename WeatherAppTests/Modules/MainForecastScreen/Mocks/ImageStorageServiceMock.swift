//
//  ImageStorageServiceMock.swift
//  WeatherAppTests
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import UIKit

class ImageStorageServiceMock: ImageStorageServiceProtocol {
    var abbreviations: [String] = []

    func saveImages(_ images: [String: UIImage]) {
    }

    func getImage(for key: String) -> UIImage? {
        nil
    }

    func saveImage(for arrb: String, image: UIImage?) {
    }
}
