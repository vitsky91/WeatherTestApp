//
//  CurrentWeatherViewController.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/16/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

class CurrentWeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        subscribeNotification()
        
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor.hexStringToUIColor(hex: Constants.CurrentWeatherColor)
    }
    
    func updateUI() {
        
        if let data = DataManager.prepareData(index: 0) {
            let userInfo = ["data": data]
            let notification = NSNotification(name: .DaySelected, object: nil, userInfo: userInfo)
            updateWeatherWith(notification)
        }
        
    }
    
    fileprivate func subscribeNotification() {
        NetworkManger.shared.networkUpdateDispatchGroup.notify(queue: .main) {[weak self] in
            self?.updateUI()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeatherWith), name: NSNotification.Name.DaySelected, object: nil)
    }
    
}

extension CurrentWeatherViewController {
    
    @objc func updateWeatherWith(_ notification: NSNotification) {
    
        if let data = notification.userInfo?["data"] as? WeatherInfoData {
            
            let tempString = "\(data[WeatherInfoParameters.min.rawValue] ?? "")° / \(data[WeatherInfoParameters.max.rawValue] ?? "")°"
         
            dateLabel.text = data[WeatherInfoParameters.day.rawValue]
            tempLabel.text = tempString
            humidityLabel.text = (data[WeatherInfoParameters.humidity.rawValue] ?? "") + " %"
            windLabel.text = (data[WeatherInfoParameters.windSpeed.rawValue] ?? "") + " м/с"
            cityLabel.text = data[WeatherInfoParameters.city.rawValue]
            
            let iconDescription = data[WeatherInfoParameters.icon.rawValue] ?? ""
            let icon = WeatherImage(rawValue: iconDescription)?.imageWhite
            
            iconImageView.image = icon
        }
    }
}
