//
//  Constants.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Combine

struct K {
    static let blue = Color("BrandBlue")
    static let lightGray = Color("BrandLightGray")
    static let darkGray = Color("BrandDarkGray")
    static let textColor = Color("BrandTextColor")
    static let frameColor = Color("BrandFrameColor")
    static let UITextColor = UIColor(named: "BrandTextColor")!
    static let UIFrameColor = UIColor(named: "BrandFrameColor")!
    static let logo = "SplashScreenBowl"
    static let bakeButton = "BakeButton"
    
    struct Time {
        static let totalTime = "Total Time"
        static let bakeTime = "Bake Time"
        static let prepTime = "Prep Time"
    }
    
    struct Font {
        static let raleway = "Raleway-Regular"
        static let light = "Raleway-Light"
        static let bold = "Raleway-Bold"
        static let italic = "Raleway-Italic"
    }
    
    struct Defaults {
        static let primaryViewIsTile = "primaryViewIsTile"
        static let timeSettingIsPermanent = "timeSettingIsPermanent"
        static let ingSettingIsPermanent = "ingSettingIsPermanent"
    }
    
    struct IngString {
        static let water = "water"
        static let milk = "milk"
        static let butter = "butter"
        static let flour = "flour"
        static let yeast = "yeast"
        static let bakingPowder = "baking powder"
        static let salt = "salt"
        static let brownSugar =  "brown sugar"
        static let sugar = "sugar"
        static let vanilla = "vanilla"
        static let vinegar = "vinegar"
        static let bakingSoda = "baking soda"
        static let egg = "egg"
        static let chocChips = "chocolate chips"
    }
    
}


extension UserDefaults {

    private struct Keys {
        static let primaryViewIsTile = "primaryViewIsTile"
    }

    static var primaryViewIsTile: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.primaryViewIsTile)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.primaryViewIsTile)
        }
    }
}
