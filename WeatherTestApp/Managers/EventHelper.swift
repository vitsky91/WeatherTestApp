//
//  EventHelper.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/19/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation

enum EventType: String {
    
    case updateRecordedForms = "event.updateRecordedForms"
}

class EventHelper {
    
    static let shared = EventHelper()
    
    private var events = [EventType]()

    public func performEvent(_ eventType: EventType) {
        
        if events.contains(eventType) == false {
            
            events.append(eventType)
        }
    }
    
    public func needToPerformEvent(_ eventType: EventType) -> Bool {
        
        return events.contains(eventType)
    }
    
    public func complitedEvent(_ eventType: EventType) {
        
        if let index = events.firstIndex(of: eventType) {
            events.remove(at: index)
        }
    }
}
