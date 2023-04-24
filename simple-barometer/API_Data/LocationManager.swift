//
//  LocationManager.swift
//  simple-barometer
//
//  Created by Michael Johnson on 3/6/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion : ((String) -> Void)?
    
    public func getUserLocation(completion: @escaping ((String) -> Void)) {
        manager.requestWhenInUseAuthorization()
        self.completion = completion
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }

            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.completion?(pm.postalCode ?? "unknown")
//                print(pm.postalCode as Any) //prints zip code
                
            } else {
                print("Problem with the data received from geocoder")
            }
        }
        
       
        manager.stopUpdatingLocation()
    }
    
}
