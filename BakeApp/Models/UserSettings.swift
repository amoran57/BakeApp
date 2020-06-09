//
//  UserSettings.swift
//  BakeApp
//
//  Created by Alex Moran on 6/9/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var timeSettingIsPermanent: Bool {
        didSet {
            UserDefaults.standard.set(timeSettingIsPermanent, forKey: K.Defaults.timeSettingIsPermanent)
        }
    }
    
    @Published var ingSettingIsPermanent: Bool {
        didSet {
            UserDefaults.standard.set(ingSettingIsPermanent, forKey: K.Defaults.ingSettingIsPermanent)
        }
    }
    
    @Published var primaryViewIsTile: Bool {
        didSet {
            UserDefaults.standard.set(primaryViewIsTile, forKey: K.Defaults.primaryViewIsTile)
        }
    }
    
    public var ringtones = ["Chimes", "Signal", "Waves"]
    
    init() {
        self.timeSettingIsPermanent = UserDefaults.standard.object(forKey: K.Defaults.timeSettingIsPermanent) as? Bool ?? true
        self.ingSettingIsPermanent = UserDefaults.standard.object(forKey: K.Defaults.ingSettingIsPermanent) as? Bool ?? true
        self.primaryViewIsTile = UserDefaults.standard.object(forKey: K.Defaults.primaryViewIsTile) as? Bool ?? true
    }
}
