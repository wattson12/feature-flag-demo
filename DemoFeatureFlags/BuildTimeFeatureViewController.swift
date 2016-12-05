//
//  BuildTimeFeatureViewController.swift
//  DemoFeatureFlags
//
//  Created by Sam Watts on 05/12/2016.
//  Copyright © 2016 Testing. All rights reserved.
//

#if BUILD_TIME_FEATURE

import UIKit
import Cartography

class BuildTimeFeatureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .random
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This is a feature using build time flags to enable / disable"
        self.view.addSubview(label)
        
        constrain(label, self.view) { label, view in
            label.centerY == view.centerY
            label.leading == view.leading + 20
            label.trailing == view.trailing - 20
        }
    }

}

#endif
