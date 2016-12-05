//
//  RunTimeFeatureViewController.swift
//  DemoFeatureFlags
//
//  Created by Sam Watts on 05/12/2016.
//  Copyright © 2016 Testing. All rights reserved.
//

import UIKit
import Cartography

class RunTimeFeatureViewController: UIViewController {
    
    var featureName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .random
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This is a feature using run time config to enable / disable. \n\nFeature Name: \(featureName ?? "")"
        self.view.addSubview(label)
        
        constrain(label, self.view) { label, view in
            label.centerY == view.centerY
            label.leading == view.leading + 20
            label.trailing == view.trailing - 20
        }
    }

}
