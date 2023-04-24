//
//  API_Strings.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation
import CoreLocation

class API_Strings {

    func get48HourString() -> String {
                
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.local
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let yesterdayString = dateFormatter.string(from: yesterday)
        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let tomorrowString = dateFormatter.string(from: tomorrow)

        
        var zip = "40241"
        
        // Make location global I think, get at startup
        LocationManager.shared.getUserLocation { location in
            zip = location
            
            // 40241 = Latitude: 38.302310, Longitude: -85.584506
//            print(location)
        }
        
        
        // message API guy to get current hour+, not 00:00:00 time
        return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(zip)/\(yesterdayString)/\(tomorrowString)?unitGroup=us&elements=datetime%2Cpressure&include=hours%2Ccurrent&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
    }
}
