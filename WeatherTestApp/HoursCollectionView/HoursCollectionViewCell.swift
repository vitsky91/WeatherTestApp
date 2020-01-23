//
//  HoursCollectionViewCell.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/14/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit

class HoursCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// Config cell
    /// - Parameter data: data model
    func config(data: ForecastWeatherListModel?) {
        
        timeLabel.attributedText = setupTime(textDate: data?.textDate)
        temperatureLabel.text = setupTemperature(temp: data?.mainWeatherData?.temp)
        weatherImageView.image = setupImage(state: data?.weatherState?.first?.icon)
    }
    
}


// MARK: - Cell setups
extension HoursCollectionViewCell {
    
    private func setupTime(textDate: String?) -> NSMutableAttributedString {
        
        let time = NSMutableAttributedString(string: textDate?.dropFirst(11).dropLast(6).description ?? "")
        let minutes = NSAttributedString(string: "00", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
             NSAttributedString.Key.baselineOffset: 5])
        time.append(minutes)
        
        return time
    }
    
    private func setupTemperature(temp: Double?) -> String {
        
        let temp = Int(temp ?? 0)
        
        return temp.description + "°"
    }
    
    private func setupImage(state: String?) -> UIImage {
        
        let onlyState = state?.dropLast().description //We dropping last char -> last char show day or night
        let state = WeatherImage.init(rawValue: onlyState ?? "")
        
        return state?.imageWhite ?? UIImage()
    }
}
