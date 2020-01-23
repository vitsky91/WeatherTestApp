//
//  TestModel.swift
//  ForecastWeatherModel
//
//  Created by Vitalii Sydorskyi on 1/17/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation

struct ForecastWeatherModel: Codable {
    let weatherList: [ForecastWeatherListModel?]
    let cityData: ForecastCityModel?
    
    enum CodingKeys: String, CodingKey {
        case weatherList = "list"
        case cityData = "city"
    }
}

struct ForecastWeatherListModel: Codable {
    let date: Double?
    let mainWeatherData: ForecastMainWeatherModel?
    let windData: ForecastWindModel?
    let weatherState: [ForecastWeatherStateModel]?
    let textDate: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case mainWeatherData = "main"
        case textDate = "dt_txt"
        case windData = "wind"
        case weatherState = "weather"
    }
}

struct ForecastWeatherStateModel: Codable {
    let id: Int?
    let state: String?
    let description: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case state = "main"
        case description = "description"
        case icon = "icon"
    }
}

struct ForecastMainWeatherModel: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct ForecastWindModel: Codable {
    let speed: Double?
    let degrees: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case degrees = "deg"
    }
}

struct ForecastCityModel: Codable {
    let name: String?
    let sunrise: Double?
    let sunset: Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}
