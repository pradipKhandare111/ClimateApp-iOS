//
//  WeatherDataStructure.swift
//  Clima
//
//  Created by NTS on 30/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDataStructure: Decodable
{
    let name : String
    let main :main
    let weather: [Weather]
    let wind: Wind
}

struct main: Codable
{
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Wind : Codable
{
    let speed: Double
    let deg: Int
}
