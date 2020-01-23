//
//  Models.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/17/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation

struct DayWeatherModel: Codable {
    let main: DayTemperatureModel?
    let dt: Double?
    let name: String?
    let sys: DaySysModel?
    let coord: DayCoordinatesModel?
    let wind: DayWindModel?
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case dt = "dt"
        case name = "name"
        case sys = "sys"
        case coord = "coord"
        case wind = "wind"
    }
}

struct DayTemperatureModel: Codable {
    let tempMax: Double?
    let tempMin: Double?
    let tempCurrent: Double?
    let feelsLike: Double?
    let humidity: Double?
    let pressure: Double?
    
    enum CodingKeys: String, CodingKey {
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case tempCurrent = "temp"
        case feelsLike = "feels_like"
        case humidity = "humidity"
        case pressure = "pressure"
    }
}

struct DaySysModel: Codable {
    let id: Int?
    let country: String?
    let sunset: Int?
    let sunrise: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case country = "country"
        case sunset = "sunset"
        case sunrise = "sunrise"
    }
}

struct DayWindModel: Codable {
    let speed: Double?
    let degrees: Double?

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case degrees = "deg"
    }
}

struct DayCoordinatesModel: Codable {
    let lon: Double?
    let lat: Double?
    
    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
}
