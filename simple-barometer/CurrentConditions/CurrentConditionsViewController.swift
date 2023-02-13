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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           
        let test = GaugeView(frame: CGRect(x: 40, y: 40, width: 256, height: 256))

        test.backgroundColor = .clear

        self.view.addSubview(test)

        test.translatesAutoresizingMaskIntoConstraints = false
        test.center = self.view.center
    }
}
