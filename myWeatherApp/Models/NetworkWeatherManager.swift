//
//  NetworkWeatherManager.swift
//  myWeatherApp
//
//  Created by Артём on 13.10.2021.
//

import Foundation

struct NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeatherData)-> Void)?
    
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data{
                let currentWeather = self.parseJSON(withData: data)
            }
            
        }
            task.resume()
        }
    
    
    func parseJSON (withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {return nil}
            return currentWeather
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
