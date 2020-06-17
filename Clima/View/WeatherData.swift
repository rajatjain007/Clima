//
//  WeatherData.swift
//  Clima
//
//  Created by Rajat Jain on 16/03/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [WeatherI]
    

}

struct Main : Codable {
    
    let temp : Float
}
struct WeatherI: Codable{
    let id : Int
}


    

