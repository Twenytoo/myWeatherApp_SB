//
//  CurrentWeather.swift
//  myWeatherApp
//
//  Created by Артём on 13.10.2021.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String{
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String{
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData){
        self.cityName = currentWeatherData.name
        self.temperature = currentWeatherData.main.temp
        self.feelsLikeTemperature = currentWeatherData.main.feelsLike
        self.conditionCode = currentWeatherData.weather.last!.id
    }
}
