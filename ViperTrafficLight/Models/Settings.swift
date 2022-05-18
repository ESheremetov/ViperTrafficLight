//
//  settings.swift
//  ViperTrafficLight
//
//  Created by Егор Шереметов on 16.05.2022.
//

import Foundation


struct Settings: Codable {
    let section: Int
    let name: String
    let rows: Array<String>
}

struct LocalSettings: Codable {
    let section: Int
    let name: String
    let cell: String
}
