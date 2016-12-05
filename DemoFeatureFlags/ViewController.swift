//
//  ViewController.swift
//  DemoFeatureFlags
//
//  Created by Sam Watts on 05/12/2016.
//  Copyright © 2016 Testing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if FEATURE_TEST == true
            print("feature is enabled")
        #else
            print("feature is not enabled")
        #endif
    }

}

