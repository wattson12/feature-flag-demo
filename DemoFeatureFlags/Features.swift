//
//  Features.swift
//  DemoFeatureFlags
//
//  Created by Sam Watts on 05/12/2016.
//  Copyright © 2016 Testing. All rights reserved.
//

import Foundation

private extension Bundle {
    
    var enabledFeatureList: [String] {
        guard let featureList = Bundle.main.object(forInfoDictionaryKey: "ENABLED_FEATURES") as? String else { return [] }
        
        return featureList.components(separatedBy: " ")
    }
}

private func featureNameFromCurrentFunction(functionName: String = #function) -> String {
    var featureName = functionName
    
    guard let rangeOfIs = featureName.range(of: "is", options: .anchored, range: nil, locale: nil) else { return "" }
    
    featureName.removeSubrange(rangeOfIs)
    
    guard let rangeOfEnabled = featureName.range(of: "Enabled", options: [.anchored, .backwards], range: nil, locale: nil) else { return "" }
    
    featureName.removeSubrange(rangeOfEnabled)
    
    return featureName.unicodeScalars.enumerated().map { index, character -> String in
        
        if CharacterSet.uppercaseLetters.contains(character) && index != 0 {
            return "_" + character.description
        }
        
        return character.description
        }.joined().uppercased()
}

enum RunFeature: String {
    case runTimeFeature
    
    var defaultsKey: String {
        return rawValue.unicodeScalars.enumerated().map { index, character -> String in
            
            if CharacterSet.uppercaseLetters.contains(character) && index != 0 {
                return "_" + character.description
            }
            
            return character.description
            }.joined().uppercased()

    }
    
    static func isEnabled(_ feature: RunFeature, inBundle bundle: Bundle = Bundle.main, checkingUserDefaults userDefaults: UserDefaults = .standard) -> Bool {
        if let userDefaultsFlag = userDefaults.object(forKey: feature.defaultsKey) as? Bool {
            return userDefaultsFlag
        }
        
        return bundle.enabledFeatureList.contains(feature.defaultsKey)
    }
}

struct Feature {
    
    @available(*, unavailable)
    private init() {}
    
    static func isFeatureEnabled(featureName: String, inBundle bundle: Bundle = Bundle.main, checkingUserDefaults userDefaults: UserDefaults = .standard) -> Bool {
        
        if let userDefaultsFlag = userDefaults.object(forKey: featureName) as? Bool {
            return userDefaultsFlag
        }
        
        return bundle.enabledFeatureList.contains(featureName)
    }
    
    static var isRunTimeFeatureEnabled: Bool {
        return isFeatureEnabled(featureName: featureNameFromCurrentFunction())
    }
}
