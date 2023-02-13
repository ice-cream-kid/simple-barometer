//
//  CurrentConditionsViewController.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/10/23.
//

import Foundation
import UIKit

class CurrentConditionsViewController : UIViewController {

    @IBOutlet weak var gaugeView : GaugeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Current Conditions"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1) {
                self.gaugeView.value = 33
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 1) {
                self.gaugeView.value = 66
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 1) {
                self.gaugeView.value = 0
            }
        }
    }
    
//    func addGaugeViewToSelf() {
//
//        let widthHeight = 400.0
//
//        let practiceGauge = GaugeView(frame: CGRect(x:view.center.x - (widthHeight / 2), y: view.center.y - (widthHeight / 2), width: 400, height: 400))
//        practiceGauge.backgroundColor = .clear
//
//        practiceGauge.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(practiceGauge)
//    }
 
}
