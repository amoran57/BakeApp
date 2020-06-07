//
//  Settings.swift
//  BakeApp
//
//  Created by Alex Moran on 6/7/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    let views = [RecipeDetail(recipe: recipeData[1]),
                 RecipeDetail(recipe: recipeData[2]),
                 RecipeDetail(recipe: recipeData[3]),
                 RecipeDetail(recipe: recipeData[4])]
    
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
                SettingsTile(text: "Set recipe view settings")
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
