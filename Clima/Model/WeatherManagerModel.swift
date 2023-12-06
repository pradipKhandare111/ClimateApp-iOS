//
//  WeatherManagerModel.swift
//  Clima
//
//  Created by NTS on 30/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManagerModel, _ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManagerModel {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=645a7bdf60164c1adf2427f676b63d12&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lattitude: CLLocationDegrees , longitude: CLLocationDegrees)
    {
        let urlString = "\(weatherUrl)&lat=\(lattitude)&lon=\(longitude)"
        performRequest(with: urlString)
            
    }
    
    func performRequest(with urlString: String){
        
        //1.
        if let url = URL(string: urlString){
            
            //2.
            let session = URLSession(configuration: .default)
            
            //3.
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
                
            }
            //.4
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(WeatherDataStructure.self, from: weatherData)
            print("\(decodedData.name) = \(decodedData.main.temp)")
            
//            print(decodedData.weather[0].description)
//            print(decodedData.wind.speed)
//            print(decodedData.wind.deg)
           // print(decodedData.weather[0].id)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temp: temp)
            print(weather.conditionName)
            print(weather.tempStringInOneDecimal)
        //    print(getConditionId(weatherId: id))
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
        
    
    
}
