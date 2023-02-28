//
//  API_Controller.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation

class API_Controller {
        
    func getWeatherDataForHome(home : Home) {
                
        guard let url = URL(string: "\(API_Strings().fortyEightHour)") else {
            print("invalid url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if String(data: data, encoding: .utf8) != nil {
                self.parseWeatherData(data: data, home: home)
            }
            
        }.resume()
    }
//            "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241?unitGroup=us&elements=datetime%2Cpressure&include=hours%2Ccurrent&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json
    
    func parseWeatherData(data : Data, home : Home) {

        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            home.updateCurrentConditions(weatherData: weatherData)

        } catch let parseError {
            print(" \n *** \n ", parseError)
        }
    }
}
