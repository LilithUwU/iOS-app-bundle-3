import UIKit
import Foundation

struct AppConfig: Codable {
    let appName: String
    let appDescription: String
    let features: Features
    let imageNames: [String]
}

struct Features: Codable {
    let numberOfImagesToShow: Int
    let imageSize: CGFloat
}

class ConfigLoader {
    static func loadConfig() -> AppConfig? {
        guard let url = Bundle.main.url(forResource: "config", withExtension: "json") else {
            print("no config.json in bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(AppConfig.self, from: data)
        } catch {
            print("decode failed for config.json: \(error)")
            return nil
        }
    }
}
