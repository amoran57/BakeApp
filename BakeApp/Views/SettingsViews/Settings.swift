//
//  Settings.swift
//  BakeApp
//
//  Created by Alex Moran on 6/7/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Combine

let defaults = UserDefaults.standard

struct Settings: View {
    @ObservedObject var userSettings = UserSettings()
    var recipe:Recipe?
    var body: some View {
        
        VStack {
                Form {
                    Section() {
                        Toggle(isOn: self.$userSettings.timeSettingIsPermanent) {
                            Text("Time preferences are permanent")
                        }
                        Toggle(isOn: self.$userSettings.ingSettingIsPermanent) {
                            Text("Ingredient preferences are permanent")
                        }
                        Toggle(isOn: self.$userSettings.primaryViewIsTile) {
                            Text("Show instructions one at a time")
                        }
                    }
                }
            
             
        }.navigationBarTitle("Settings")
            .onDisappear {
                if let validRecipe = self.recipe {
                    
                }
        }
        //
//        VStack {
//
//            Spacer()
//
//            HStack {
//
//                Spacer()
//
//                ZStack {
//
//                    VStack{
//
//                        NavigationLink(destination: SetTimePermanence()) {
//
//                            ZStack {
//                                Rectangle()
//                                    .frame(width: 150, height: 120)
//                                    .cornerRadius(20)
//                                    .foregroundColor(K.frameColor)
//
//                                Text("Make Time Preferences \(userSettings.timeSettingIsPermanent ? "Temporary" : "Permanent")")
//                                    .foregroundColor(K.textColor)
//                                    .multilineTextAlignment(.center)
//                                    .frame(width:150, height: 120, alignment: .center)
//                            }
//
//                        }
//
//                        Rectangle()
//                            .frame(width: 140, height: 2)
//                            .foregroundColor(K.frameColor)
//                            .padding(.vertical, -2)
//
//                        NavigationLink(destination:SelectTimeScreen(showSettings:false)) {
//
//                            ZStack {
//                                Rectangle()
//                                    .frame(width: 150, height: 120)
//                                    .cornerRadius(20)
//                                    .foregroundColor(K.frameColor)
//
//                                Text("Adjust current time settings")
//                                    .padding()
//                                    .foregroundColor(K.textColor)
//                                    .multilineTextAlignment(.center)
//                                    .frame(width:150, height: 120, alignment: .center)
//
//                            }
//                        }
//                    }
//                }.frame(width: 150, height: 250)
//                Spacer()
//
//
//                ZStack {
//
//                    VStack{
//
//                        NavigationLink(destination: SetIngredientPermanence()) {
//
//                            ZStack {
//                                Rectangle()
//                                    .frame(width: 150, height: 120)
//                                    .cornerRadius(20)
//                                    .foregroundColor(K.frameColor)
//
//                                Text("Make Ingredient Preferences \(defaults.bool(forKey: K.Defaults.ingSettingIsPermanent) ? "Temporary" : "Permanent")")
//                                    .foregroundColor(K.textColor)
//                                    .multilineTextAlignment(.center)
//                                    .frame(width:150, height: 120, alignment: .center)
//                            }
//
//                        }
//
//                        Rectangle()
//                            .frame(width: 140, height: 2)
//                            .foregroundColor(K.frameColor)
//                            .padding(.vertical, -2)
//
//                        NavigationLink(destination:SelectIngredientsOwned(showSettings:false)) {
//
//                            ZStack {
//                                Rectangle()
//                                    .frame(width: 150, height: 120)
//                                    .cornerRadius(20)
//                                    .foregroundColor(K.frameColor)
//
//                                Text("Adjust current ingredient settings")
//                                    .padding()
//                                    .foregroundColor(K.textColor)
//                                    .multilineTextAlignment(.center)
//                                    .frame(width:150, height: 120, alignment: .center)
//
//                            }
//                        }
//                    }
//                }.frame(width: 150, height: 250)
//
//                Spacer()
//            }
//
//            Spacer()
//
//            HStack {
//                Spacer()
//                NavigationLink(destination: SetRecipeDetailView()) {
//                    SettingsTile(text: "Set recipe view settings")
//                }
//                Spacer()
//                SettingsTile(text: "Remove a recipe")
//                Spacer()
//            }
//            Spacer()
//        }.navigationBarTitle(Text("Settings").foregroundColor(K.textColor))
//
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
