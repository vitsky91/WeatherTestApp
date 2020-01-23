//
//  Double+Extension.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/17/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation

extension Double {
    
    /// Get date string from UTC
    func dateStringFromUTC() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateStyle = .full
        
        return dateFormatter.string(from: date)
    }
}
