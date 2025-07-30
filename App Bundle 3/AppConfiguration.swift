//
//  AppConfiguration.swift
//  App Bundle 3
//
//  Created by lilit on 30.07.25.
//

import Foundation

struct AppConfiguration: Decodable {
    let appTitle: String
    let numberOfImagesToDisplay: Int
    let welcomeMessage: String
}
