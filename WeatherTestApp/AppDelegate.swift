//
//  AppDelegate.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/10/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkManger.shared.getWeatherData()
        DataManager.getCitiesArray()
        
        return true
    }
    
}

