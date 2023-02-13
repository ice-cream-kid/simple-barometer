//
//  Home.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/9/23.
//

import Foundation
import UIKit

class Home : UIViewController {
    
    @IBOutlet weak var titleStackViewContainer : UIView!
    @IBOutlet weak var titleStackView : UIStackView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    
    @IBOutlet weak var homePanelsStackView : UIStackView!
    
    @IBOutlet weak var currentConditionsView : UIView!
    @IBOutlet weak var currentConditionsLabel : UILabel!
    @IBOutlet weak var currentConditionsButton : UIButton!
    
    @IBOutlet weak var currentPressureNumericLabel : UILabel!
    @IBOutlet weak var currentConditionsGaugeContainerView: UIView!
    @IBOutlet weak var currentPressureUnitLabel : UILabel!

    @IBOutlet weak var dayView : UIView!
    @IBOutlet weak var dayViewLabel : UILabel!
    @IBOutlet weak var dayViewButton : UIButton!
    
    @IBOutlet weak var tenDayView : UIView!
    @IBOutlet weak var tenDayViewLabel : UILabel!
    @IBOutlet weak var tenDayViewButton : UIButton!
    
    @IBOutlet weak var bottomInformationView : UIView!
    @IBOutlet weak var bottomInformationLabel : UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        API_Controller().getBlobForHome(home: self)
        
//        self.currentPressureNumericLabel.isHidden = true
    }
    
    func updateCurrentConditions(updatedBlob : Blob) {
        
        var mercuryValue : Double = (updatedBlob.currentConditions.pressure / 33.864);
        
//        print(mercuryValue)
        
        DispatchQueue.main.async {
            self.currentPressureUnitLabel.text = String(format: "%.2f inHg", mercuryValue)
        }
        
        
    }
    
    
    
    
}
