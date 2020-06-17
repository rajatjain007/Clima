//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{


    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = Weather()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
      
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    

   
    
   
}

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
           searchTextField.endEditing(true)
           
       }
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           print(searchTextField.text!)
           searchTextField.endEditing(true)
           return true
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
           if let city = searchTextField.text{
               weatherManager.fetchWeather(cityName: city)
               
               

           }
           searchTextField.text = ""
          
       }
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != "" {
               return true
           }
           else{
               textField.placeholder = "Enter a city name"
               return false
           }
       }
}

extension WeatherViewController : WeatherDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
        print(weather.cityName)
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName : "\(weather.conditionName)")
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension WeatherViewController : CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("Got location")
            if let location = locations.last{
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                weatherManager.fetchWeather(latitude : lat, longitude : long)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    }
    

