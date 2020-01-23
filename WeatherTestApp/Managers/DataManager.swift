//
//  DataManager.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/19/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation

typealias WeatherInfoData = [String: String]

enum WeatherInfoParameters: String, CaseIterable {
    case icon = "icon"
    case min = "min"
    case max = "max"
    case humidity = "humidity"
    case city = "city"
    case windSpeed = "windSpeed"
    case day = "day"
}

class DataManager {
    
    static var citiesArray = [CityModel]()
    
    /// Get weather data by setted parameters
    /// - Parameters:
    ///   - data: Data model (Default model from NetworkManger)
    ///   - index: What day should be returned
    ///   - options: Parameters what will be returned (Default all cases will be returned)
    static func prepareData(data: ForecastWeatherModel? = NetworkManger.shared.weatherModel, index: Int, options: [WeatherInfoParameters]? = WeatherInfoParameters.allCases) -> WeatherInfoData? {
        
        guard let data = data else { return nil }
        
        let dayString = day(index)
        let currentDayArray = data.weatherList.filter({$0?.date?.dateStringFromUTC() == dayString})
        
        var paramsToReturn = [String: String]()
        
        options?.forEach({ (parameter) in
            switch parameter {
            case .icon:
                paramsToReturn[parameter.rawValue] = getDayIcon(data: currentDayArray as! [ForecastWeatherListModel])
            case .max:
                paramsToReturn[parameter.rawValue] = getMaxTemp(data: currentDayArray as! [ForecastWeatherListModel])
            case .min:
                paramsToReturn[parameter.rawValue] = getMinTemp(data: currentDayArray as! [ForecastWeatherListModel])
            case .day:
                paramsToReturn[parameter.rawValue] = dayString
            case .city:
                paramsToReturn[parameter.rawValue] = data.cityData?.name
            case .windSpeed:
                if currentDayArray.isEmpty == false, let param = currentDayArray[0]?.windData?.speed?.description {
                    paramsToReturn[parameter.rawValue] = param
                }
            case .humidity:
                paramsToReturn[parameter.rawValue] = getHumidity(data: currentDayArray as! [ForecastWeatherListModel])
            }
        })
        
        return paramsToReturn
    }
    
    static func getAllWeatherOfDay(_ ofDay: String? = nil) -> [ForecastWeatherListModel?]? {
        
        let currentDay = ofDay != nil ? ofDay : Double(Date().timeIntervalSince1970).dateStringFromUTC()
        
        let currentDayArray = NetworkManger.shared.weatherModel?.weatherList.filter({$0?.date?.dateStringFromUTC() == currentDay})
        
        return currentDayArray
    }
}

// MARK: - Private data processing
extension DataManager {
    
    /// Get day description by adding value
    /// - Parameter value: 0 -> current day, 1 -> tommorow, -1 -> yesterday
    private static func day(_ value: Int? = 0) -> String {
        
        let dayDate = Calendar.current.date(byAdding: .day, value: value ?? 0, to: Date())
        return Double(dayDate?.timeIntervalSince1970 ?? Date().timeIntervalSince1970).dateStringFromUTC()
    }
    
    private static func getDayIcon(data: [ForecastWeatherListModel]) -> String {
        var statesOfDay = [String]()
        
        data.forEach { (model) in
            let iconText = model.weatherState?.first?.icon?.dropLast().description
            if let state = iconText {
                statesOfDay.append(state)
            }
        }
        
        let index = statesOfDay.count / 2
        let iconDescription = statesOfDay.isEmpty ? "" : statesOfDay[index]
        return iconDescription
    }
    
    private static func getMinTemp(data: [ForecastWeatherListModel]) -> String {
        var temp = 0
        data.forEach { (model) in
            if Int(model.mainWeatherData?.temp ?? 0) < temp {
                temp = Int(model.mainWeatherData?.temp ?? 0)
            }
        }
        return temp.description
    }
    
    private static func getMaxTemp(data: [ForecastWeatherListModel]) -> String {
        var temp = 0
        data.forEach { (model) in
            if Int(model.mainWeatherData?.temp ?? 0) > temp {
                temp = Int(model.mainWeatherData?.temp ?? 0)
            }
        }
        return temp.description
    }
    
    private static func getHumidity(data: [ForecastWeatherListModel]) -> String {
        var humidityToReturn = [String]()
        
        data.forEach { (model) in
            let humidity = model.mainWeatherData?.humidity?.description ?? ""
            humidityToReturn.append(humidity)
        }
        
        let index = humidityToReturn.count / 2
        let humidityDescription = humidityToReturn.isEmpty ? "" : humidityToReturn[index]
        return humidityDescription
    }
    
}

struct CityModel: Codable {
    
    var city: String?
    var lat: String?
    var lng: String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case lat = "lat"
        case lng = "lng"
    }
}


//City json parsing
extension DataManager {
    
    static func getCitiesArray() {
        if let url = Bundle.main.url(forResource: "ua", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityModel].self, from: data)
                self.citiesArray = jsonData
            } catch {
                // handle error
            }
        }
    }
}
