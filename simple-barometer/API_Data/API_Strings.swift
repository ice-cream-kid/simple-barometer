//
//  API_Strings.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation
import CoreLocation

class API_Strings {
    
    let pressure40241 : String = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241?unitGroup=us&elements=datetime%2Cpressure&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
    
    func get48HourString() -> String {
        
        var todayString = ""
        var ydayString = ""
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone.local
        
        todayString = dateFormatter.string(from: today)
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        ydayString = dateFormatter.string(from:yesterday)
        
        var zip = "40241"
        
        // Make location global I think
        
        LocationManager.shared.getUserLocation { location in
            zip = location
            
            // 40241 = Latitude: 38.302310, Longitude: -85.584506
            print(location)
        }
        
        
        return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(zip)/\(ydayString)/\(todayString)?unitGroup=us&elements=datetime%2Cpressure&include=hours%2Ccurrent&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
    }
    
    let pastAndFutureDays : String = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241/2023-02-18/2023-03-07?unitGroup=us&elements=datetime%2Cpressure&include=days%2Chours%2Ccurrent%2Cobs%2Cfcst&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"

}
