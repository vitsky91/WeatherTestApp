//
//  DaysTableViewCell.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/18/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(data: WeatherInfoData) {
        
        let tempString = "\(data[WeatherInfoParameters.min.rawValue] ?? "")° / \(data[WeatherInfoParameters.max.rawValue] ?? "")°"
        
        var string = ""
        if let index = data[WeatherInfoParameters.day.rawValue]?.firstIndex(of: ",") {
            let firstPart = data[WeatherInfoParameters.day.rawValue]?.prefix(upTo: index)
            string = firstPart?.description ?? ""
        }
        
        dayLabel.text = string
        temperatureLabel.text = tempString
        weatherIcon.image = WeatherImage(rawValue: data[WeatherInfoParameters.icon.rawValue] ?? "")?.imageBlack
        
    }
    
}


