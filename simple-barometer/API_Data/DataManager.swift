//
//  DataManager.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation
    
struct Blob : Codable {
    
    let days : [Day]
    let currentConditions : CurrentConditions
    
    struct Day : Codable {
        
        let datetime : String
        let pressure : Double
        let hours : [Hour]
        
        struct Hour : Codable {
            
            let datetime : String
            let pressure : Double
        }
    }
    
    struct CurrentConditions : Codable {
        
        let datetime : String
        let pressure : Double
        
    }
}
    
