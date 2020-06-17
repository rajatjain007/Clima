//
//  WeatherManager.swift
//  Clima
//
//  Created by Rajat Jain on 16/03/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDelegate {
    func didUpdateWeather(weather : WeatherModel)
    func didFailWithError(error : Error)
}

struct Weather {
    let apiKey = "7dc5675fb812ee5f0913a88cc1b4b37b"
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=7dc5675fb812ee5f0913a88cc1b4b37b&units=metric"
    var delegate : WeatherDelegate?
    
    func fetchWeather(cityName : String){
        let urlString = "\(url)"+"&q="+"\(cityName)"
        performRequest(with: urlString)
        
    }
   func fetchWeather(latitude : CLLocationDegrees,longitude : CLLocationDegrees) {
    let urlString = "\(url)"+"&"+"lat=\(latitude)"+"&lon=\(longitude)"
    performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                   
                    return
                }
                
                if let safeData = data{
                   let weather = self.parseJSON(safeData)
                    self.delegate?.didUpdateWeather(weather : weather)
                }
                
            }
            task.resume()
        }
        
        
        
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel{
        let decoder = JSONDecoder()
        do{
          let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            print(weather.cityName)
            print(weather.temperature)
            print(weather.conditionName)
            
            return weather
            
        }
        catch{
            self.delegate?.didFailWithError(error: error)
           
            return WeatherModel(conditionID: 0, cityName: "NA", temperature: 0.00)
            
            
        }
        
        
    }
}
