//
//  WeatherModel.swift
//  Clima
//
//  Created by NTS on 01/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel
{
    let conditionId: Int
    let cityName: String
    let temp: Double
    
    
    
    
    var tempStringInOneDecimal: String {
        
         return String(format: "%.1f", temp)
    }
    
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "cloud.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "Cloud"
        }
    }
    
}
