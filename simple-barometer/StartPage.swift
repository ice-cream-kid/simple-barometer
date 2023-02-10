//
//  StartPage.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/9/23.
//

import Foundation
import UIKit

class StartPage : UIViewController {
    
    @IBOutlet weak var titleStackViewContainer : UIView!
    @IBOutlet weak var titleStackView : UIStackView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    
    @IBOutlet weak var startPagePanelsStackView : UIStackView!
    
    @IBOutlet weak var currentConditionsView : UIView!
    @IBOutlet weak var currentConditionsLabel : UILabel!
    @IBOutlet weak var currentConditionsButton : UIButton!

    @IBOutlet weak var dayView : UIView!
    @IBOutlet weak var dayViewLabel : UILabel!
    @IBOutlet weak var dayViewButton : UIButton!
    
    @IBOutlet weak var tenDayView : UIView!
    @IBOutlet weak var tenDayViewLabel : UILabel!
    @IBOutlet weak var tenDayViewButton : UIButton!
    
    @IBOutlet weak var bottomInformationView : UIView!
    @IBOutlet weak var bottomInformationLabel : UILabel!

    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.red
    }
}
