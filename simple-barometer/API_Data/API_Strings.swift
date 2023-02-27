//
//  API_Strings.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation

class API_Strings {

    let pressure40241 : String = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241?unitGroup=us&elements=datetime%2Cpressure&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
    
    // interploate last 24 and
    
    let fortyEightHour : String = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241/2023-02-26/2023-02-27?unitGroup=us&elements=datetime%2Cpressure&include=days%2Chours%2Ccurrent%2Cobs%2Cfcst&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
    
    // figure interpolate last 7 and next 7
    
    let pastAndFutureDays : String = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241/2023-02-18/2023-03-07?unitGroup=us&elements=datetime%2Cpressure&include=days%2Chours%2Ccurrent%2Cobs%2Cfcst&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
}
