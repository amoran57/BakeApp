//
//  Settings.swift
//  BakeApp
//
//  Created by Alex Moran on 6/7/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI


let defaults = UserDefaults.standard

struct Settings: View {
    
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: SelectTimeScreen()) {
                SettingsTile(text: "Permanently set time preferences")
                }
                Spacer()
                NavigationLink(destination: SelectIngredientsOwned()) {
                SettingsTile(text: "Permanently set ingredient preferences")
                }
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: SetRecipeDetailView()) {
                SettingsTile(text: "Set recipe view settings")
                }
                Spacer()
                SettingsTile(text: "Remove a recipe")
                Spacer()
            }
            Spacer()
        }.navigationBarTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
