//
//  ImageLoader.swift
//  App Bundle 3
//
//  Created by lilit on 30.07.25.
//
import UIKit

class ImageLoader {
    static func loadImages(maxCount: Int) -> [UIImage] {
        let names = ["image1", "image2", "image3", "image4", "image5"]
        var images: [UIImage] = []

        for i in 0..<min(maxCount, names.count) {
            if let img = UIImage(named: names[i]) {
                images.append(img)
            }
        }

        if images.isEmpty, let fallback = UIImage(systemName: "photo") {
            images.append(fallback)
        }

        return images
    }
}

