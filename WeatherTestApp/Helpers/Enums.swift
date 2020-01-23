//
//  Enums.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/18/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

enum WeatherImage: String {
    case Clear = "01"
    case Cloud = "02"
    case Cloudy = "03"
    case Clouds = "04"
    case Rain = "10"
    case HeavyRain = "09"
    case Thunderstorm = "11"
    case Snow = "13"
    case Mist = "50"
    
    var imageWhite: UIImage {
        
        switch self {
        case .Clear:
            return UIImage(named: "sunWhite") ?? UIImage()
        case .Cloud, .Clouds:
            return UIImage(named: "cloudWhite") ?? UIImage()
        case .Cloudy:
            return UIImage(named: "cloudyWhite") ?? UIImage()
        case .Rain:
            return UIImage(named: "rainWhite") ?? UIImage()
        case .HeavyRain:
            return UIImage(named: "heavy-rainWhite") ?? UIImage()
        case .Thunderstorm:
            return UIImage(named: "lightningWhite") ?? UIImage()
        case .Snow:
            return UIImage(named: "snowWhite") ?? UIImage()
        case .Mist:
            return UIImage(named: "mistWhite") ?? UIImage()
        }
    }
    
    var imageBlack: UIImage {
        
        switch self {
        case .Clear:
            return UIImage(named: "sunBlack") ?? UIImage()
        case .Cloud, .Clouds:
            return UIImage(named: "cloudBlack") ?? UIImage()
        case .Cloudy:
            return UIImage(named: "cloudyBlack") ?? UIImage()
        case .Rain:
            return UIImage(named: "rainBlack") ?? UIImage()
        case .HeavyRain:
            return UIImage(named: "heavy-rainBlack") ?? UIImage()
        case .Thunderstorm:
            return UIImage(named: "lightningBlack") ?? UIImage()
        case .Snow:
            return UIImage(named: "snowBlack") ?? UIImage()
        case .Mist:
            return UIImage(named: "mistBlack") ?? UIImage()
        }
    }
}
