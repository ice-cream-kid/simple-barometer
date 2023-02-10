//
//  API_Controller.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation

class API_Controller {
    
    let apiString : String = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/40241?unitGroup=us&elements=datetime%2Cpressure&key=DYZHXUK8W6YCGKMARDCELVA3W&contentType=json"
    
    func getBlob() {
        
        guard let url = URL(string: "\(apiString)") else {
            print("invalid url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if let str = String(data: data, encoding: .utf8) {
//            print(str)
               
                do {
                    let blob = try JSONDecoder().decode(Blob.self, from: data)
                    print(blob)
//                    self.blob.append(show)

                } catch let parseError {
                    print(" \n *** \n ", parseError)
                }
            }
            
        }.resume()
    }
    
    func parseBlob() {
        
    }
    
    func getCurrentPressure() -> Double {
        
        self.getBlob()
        self.parseBlob()
        
        return 00.00
    }
    
}
