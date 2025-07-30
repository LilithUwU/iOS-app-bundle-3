//
//  ConfigLoader.swift
//  App Bundle 3
//
//  Created by lilit on 30.07.25.
//
import Foundation

class ConfigLoader {
    static func loadConfiguration() -> AppConfiguration? {
        guard let url = Bundle.main.url(forResource: "config", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("config.json not found.")
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(AppConfiguration.self, from: data)
    }
    
    static func printJson() {
        if let url = Bundle.main.url(forResource: "config", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let rawJson = String(data: data, encoding: .utf8)
                print("config.json \n\(rawJson ?? "Could not decode data")")
            } catch {
                print("Failed to load config.json: \(error.localizedDescription)")
            }
        } else {
            print("config.json not found in bundle.")
        }
    }
}

