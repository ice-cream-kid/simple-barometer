//
//  API_Controller.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation

class API_Controller {
    
//    var dataBlob : Blob?
    
    func getBlobForHome(home : StartPage) {
                
        guard let url = URL(string: "\(API_Strings().pressure40241)") else {
            print("invalid url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if String(data: data, encoding: .utf8) != nil {
                self.parseBlob(data: data, home: home)
            }
            
        }.resume()
    }
    
    func parseBlob(data : Data, home : StartPage) {

        do {
            let blob = try JSONDecoder().decode(Blob.self, from: data)
//            dataBlob = blob
//            print(dataBlob?.currentConditions.pressure as Any)
            
            home.updateCurrentConditions(updatedBlob: blob)

        } catch let parseError {
            print(" \n *** \n ", parseError)
        }
    }
    
//    func getCurrentPressure() -> Double {
//        
//        self.getBlob()
//        
//        
//        
////        return dataBlob?.currentConditions.pressure ?? 00.00
//    }
    
}
