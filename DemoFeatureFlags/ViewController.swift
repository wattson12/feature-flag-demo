//
//  ViewController.swift
//  DemoFeatureFlags
//
//  Created by Sam Watts on 05/12/2016.
//  Copyright © 2016 Testing. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feature Demo"
        
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 10
        self.view.addSubview(stackView)
        
        constrain(stackView, self.view) { stack, view in
            stack.top == self.topLayoutGuideCartography + 10
            stack.left == view.left + 10
            stack.right == view.right - 10
            stack.bottom <= view.bottom - 10
        }
        
        #if BUILD_TIME_FEATURE
            
            let button = UIButton(type: .custom)
            button.setTitle("Use build time feature", for: .normal)
            button.addTarget(self, action: #selector(ViewController.presentBuildTimeFeature), for: .touchUpInside)
            button.backgroundColor = .random
            
            stackView.addArrangedSubview(button)
        
        #endif
        
        if RunFeature.isEnabled(.runTimeFeature) {
            
            let button = UIButton(type: .custom)
            button.setTitle("Use run time feature", for: .normal)
            button.addTarget(self, action: #selector(ViewController.presentRunTimeFeature), for: .touchUpInside)
            button.backgroundColor = .random
            
            stackView.addArrangedSubview(button)
        }
        
        if Feature.isFeatureEnabled(featureName: "USER_DEFAULTS_FEATURE") {
            
            let button = UIButton(type: .custom)
            button.setTitle("Use user defaults overriden feature", for: .normal)
            button.addTarget(self, action: #selector(ViewController.presentUserDefaultsFeature), for: .touchUpInside)
            button.backgroundColor = .random
            
            stackView.addArrangedSubview(button)
        }
    }
    
#if BUILD_TIME_FEATURE
    func presentBuildTimeFeature() {
        let viewController = BuildTimeFeatureViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
#endif

    func presentRunTimeFeature() {
        let viewController = RunTimeFeatureViewController()
        viewController.featureName = "RUN_TIME_FEATURE"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentUserDefaultsFeature() {
        let viewController = RunTimeFeatureViewController()
        viewController.featureName = "USER_DEFAULTS_FEATURE"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

