//
//  NetworkWeatherManager.swift
//  myWeatherApp
//
//  Created by Артём on 13.10.2021.
//

import Foundation
import CoreLocation

struct NetworkWeatherManager {
    
    enum RequestType {
        case cityName (city: String)
        case cootdinate (latidute: CLLocationDegrees, longidute: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather)-> Void)?
    
    func fetchCurrentWeather (forRequestType requestType: RequestType){
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
            urlString  = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .cootdinate(let latitude, let longitude):
            urlString  = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }

    fileprivate func performRequest(withURLString urlString: String){
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data{
                if let currentWeather = self.parseJSON(withData: data){
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON (withData data: Data) -> CurrentWeather? {
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
