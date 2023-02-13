//
//  CurrentConditionsViewController.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation
import UIKit

class CurrentConditionsViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Current Conditions"
    }
    
    func addGaugeViewToSelf() {
        
        let widthHeight = 400.0
        
        let practiceGauge = GaugeView(frame: CGRect(x:view.center.x - (widthHeight / 2), y: view.center.y - (widthHeight / 2), width: 400, height: 400))
        practiceGauge.backgroundColor = .clear

        practiceGauge.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(practiceGauge)
    }
 
}
