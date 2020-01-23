//
//  NetworkManger.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/15/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import Alamofire

enum SystemOfMeasurement: String {
    case Celsius = "metric"
    case Fahrenheit = "imperial"
    case Kelvin = ""
}

class NetworkManger {
    
    static let shared = NetworkManger()
    
    //Using DispatchGroup to react on changes
    let networkUpdateDispatchGroup = DispatchGroup()
    
    var weatherModel: ForecastWeatherModel?
    
    func getWeatherData(lon: Double? = nil, lat: Double? = nil) {
        
        let requstURL = ((lon == nil) && (lat == nil)) ? requestUrl(systemMesurment: .Celsius) : requestUrl(systemMesurment: .Celsius, lon: lon, lat: lat)
        
        networkUpdateDispatchGroup.enter()
        
        Alamofire.request(requstURL).responseData { (response) in
            
            if let data = response.data {
                
                let jsDecoder = JSONDecoder()
                let weatherData = try? jsDecoder.decode(ForecastWeatherModel.self, from: data)
                self.weatherModel = weatherData
            } else if let err = response.error {
                
                print(err.localizedDescription)
            }
            
            if let data = DataManager.prepareData(index: 0) {

                let notification = ["data": data]
                NotificationCenter.default.post(name: .DaySelected, object: nil, userInfo: notification)
            }
            
            self.networkUpdateDispatchGroup.leave()
            
        }
    }
    
    //For now it's not nessesary, we can use it to get location if geolocation disabled
    fileprivate func getIpLocation(completion: @escaping(NSDictionary?, Error?) -> Void) {
        let url     = URL(string: "http://ip-api.com/json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let content = data {
                    do { if let object = try JSONSerialization.jsonObject(with: content, options: .allowFragments) as? NSDictionary {
                            completion(object, error)
                        } else {
                            // TODO: Create custom error.
                            completion(nil, nil)
                        }
                    }
                        
                    catch {
                        // TODO: Create custom error.
                        completion(nil, nil)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }).resume()
    }
    
}

extension NetworkManger {
    
    /// Link Layout with parameters
    /// - Parameters:
    ///   - systemMesurment: Enum: Celsius, Fahrenheit, Kelvin
    ///   - fewDaysWeather: Bool: true - few days request, false - one day
    private func requestUrl(systemMesurment: SystemOfMeasurement, lon: Double? = nil, lat: Double? = nil) -> String {
        
        let language = "en"
        let url = "https://api.openweathermap.org/data/2.5"
        let apiKey = "213a683e43f9c04006135217e02dda1b"
        
        var cityNameUrl = "\(url)/forecast/?q=Zaporizhia&appid=\(apiKey)&units=\(systemMesurment.rawValue)&lang=\(language)"
        
        if let lattitude = lat?.description, let longtitude = lon?.description {
            cityNameUrl = "\(url)/forecast/?lat=\(lattitude)&lon=\(longtitude)&appid=\(apiKey)&units=\(systemMesurment.rawValue)&lang=\(language)"
        }
        
//        let coordsURL = "\(url)/forecast/?lat=\(lat?.description))&lon=\(lon?.description))&appid=\(apiKey)&units=\(systemMesurment.rawValue)&lang=\(language)"
//        let coordsURL = "https://api.openweathermap.org/data/2.5/forecast/?lat=50.433333&lon=30.516667&appid=213a683e43f9c04006135217e02dda1b&units=metric&lang=en"
        
        return cityNameUrl
        
    }
}
