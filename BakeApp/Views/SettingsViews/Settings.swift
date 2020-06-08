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
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 250)
                        .cornerRadius(20)
                        .foregroundColor(K.frameColor)
                    VStack{
                        NavigationLink(destination: SetTimePermanence()) {
                            Text("Make Time Preferences Permanent/Temporary")
                                .foregroundColor(K.textColor)
                                .multilineTextAlignment(.center)
                                .frame(height: 120, alignment: .center)
                        }
                        
                        Divider()
                            .foregroundColor(K.textColor)
                        
                        NavigationLink(destination:SelectTimeScreen(showSettings:false)) {
                            Text("Adjust current time settings")
                            .padding()
                                .frame(height: 120)
                            .foregroundColor(K.textColor)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                    }
                }.frame(width: 150, height: 250)
                Spacer()
                
                
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 250)
                        .cornerRadius(20)
                        .foregroundColor(K.frameColor)
                    VStack{
                        NavigationLink(destination: SetIngredientPermanence()) {
                            Text("Make Ingredient Preferences Permanent/Temporary")
                                .foregroundColor(K.textColor)
                                .multilineTextAlignment(.center)
                                .frame(height: 120, alignment: .center)
                        }
                        
                        Divider()
                        .foregroundColor(K.textColor)
                        
                        NavigationLink(destination:SelectIngredientsOwned(showSettings:false)) {
                            Text("Adjust current ingredient settings")
                            .padding()
                            .foregroundColor(K.textColor)
                            .multilineTextAlignment(.center)
                                .frame(height: 120)
//                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                    }
                }.frame(width: 150, height: 250)
                
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
        }.navigationBarTitle(Text("Settings").foregroundColor(K.textColor))
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
