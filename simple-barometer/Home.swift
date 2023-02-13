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
    
// Current conditions panel
    @IBOutlet weak var currentConditionsView : UIView!
    @IBOutlet weak var currentConditionsLabel : UILabel!
    @IBOutlet weak var currentConditionsButton : UIButton!
    
    @IBOutlet weak var currentPressureNumericLabel : UILabel!
    @IBOutlet weak var currentConditionsGaugeContainerView: UIView!
    @IBOutlet weak var currentPressureUnitLabel : UILabel!

// Today view panel
    @IBOutlet weak var dayView : UIView!
    @IBOutlet weak var dayViewLabel : UILabel!
    @IBOutlet weak var dayViewButton : UIButton!
    
    @IBOutlet weak var lineChartContainerView: UIView!
    
// Ten day panel
    @IBOutlet weak var tenDayView : UIView!
    @IBOutlet weak var tenDayViewLabel : UILabel!
    @IBOutlet weak var tenDayViewButton : UIButton!
    
    @IBOutlet weak var bottomInformationView : UIView!
    @IBOutlet weak var bottomInformationLabel : UILabel!

    var currentPressure : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentPressureNumericLabel.isHidden = true
        API_Controller().getBlobForHome(home: self)

        self.currentConditionsView.layer.cornerRadius = 7.0
        self.dayView.layer.cornerRadius = 7.0
        self.tenDayView.layer.cornerRadius = 7.0
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//
//        let test = GaugeView(frame: CGRect(x: self.currentConditionsGaugeContainerView.frame.origin.x, y: self.currentConditionsGaugeContainerView.frame.origin.y, width: self.currentConditionsGaugeContainerView.frame.self.height, height: self.currentConditionsGaugeContainerView.frame.self.height))
//
//        test.backgroundColor = .systemGreen
//
//
//        self.currentConditionsGaugeContainerView.addSubview(test)
//
//        test.translatesAutoresizingMaskIntoConstraints = false

//        test.topAnchor.constraint(equalTo: self.currentConditionsGaugeContainerView.topAnchor, constant: 0).isActive = true
//        test.bottomAnchor.constraint(equalTo: self.currentConditionsGaugeContainerView.bottomAnchor, constant: 0).isActive = true
//        test.leadingAnchor.constraint(equalTo: self.currentConditionsGaugeContainerView.leadingAnchor, constant: 0).isActive = true
//        test.trailingAnchor.constraint(equalTo: self.currentConditionsGaugeContainerView.trailingAnchor, constant: 0).isActive = true
        
//        test.frame.size.width = self.currentConditionsGaugeContainerView.frame.size.width
    }
    
    func updateCurrentConditions(updatedBlob : Blob) {
        
        let mercuryValue : Double = (updatedBlob.currentConditions.pressure / 33.864);
        self.currentPressure = mercuryValue
        
        DispatchQueue.main.async {
            self.currentPressureNumericLabel.text = String(format: "%.2f", mercuryValue)
        }
    }
    
}
