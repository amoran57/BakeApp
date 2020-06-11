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
    @State private var showPopover = false
    @State private var disableRestore = true
    var body: some View {
        
        VStack {
            Form {
                Section() {
                    Toggle( isOn: self.$userSettings.timeSettingIsPermanent) {
                        Text("Time preferences are permanent")
                    }
                    
                    Toggle(isOn: self.$userSettings.ingSettingIsPermanent) {
                        Text("Ingredient preferences are permanent")
                    }
                    
                    Toggle(isOn: self.$userSettings.primaryViewIsTile) {
                        Text("Show instructions one at a time")
                    }
                }
                
                Section() {
                    NavigationLink(destination: RemoveRecipe()) {
                        VStack(alignment: .leading) {
                        Text("Remove recipe")
                            Text("Tried one of our recipes and didn't like it? You can remove that recipe from BakeApp, so it will never come up again.")
                                .font(.caption)
                        }
                    }
                    
                    NavigationLink(destination: RestoreRecipe()) {
                        VStack(alignment: .leading) {
                        Text("Restore removed recipes")
                        Text("Changed your mind? You can always restore your removed recipes here.")
                        .font(.caption)
                        }
                    }.disabled(disableRestore)
                }
                
                Section() {
                    Button(action: {
                        self.showPopover.toggle()
                    }) {
                        Text("Contact us")
                            .foregroundColor(K.blue)
                    }.overlay(
                        ZStack { if self.showPopover {
                            Rectangle()
                                .frame(width: 350, height: 70)
                                .foregroundColor(K.frameColor)
                                .cornerRadius(20)
                            
                            Text("Send us an email at bakeapp@gmail.com!")
                                .foregroundColor(K.textColor)
                                .frame(width: 350, height: 70)
                            }
                        }.frame(width: 350, height: 120, alignment:.bottom)
                            .animation(.easeOut(duration: 0.3))
                        , alignment: .topLeading
                    )
                    
                    }
                     
            }.foregroundColor(K.textColor)
            
        }
        .navigationBarTitle("Settings")
        .onAppear(perform: {self.disableRestore = (defaults.array(forKey: K.Defaults.removedRecipeIndex) as! Array<Int>).count == 0 ? true : false})
       
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
