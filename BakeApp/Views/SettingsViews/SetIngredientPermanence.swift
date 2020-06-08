//
//  SetIngredientPermanence.swift
//  BakeApp
//
//  Created by Alex Moran on 6/8/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct SetIngredientPermanence: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        VStack {
            Button(action: {
                defaults.set(true, forKey: K.Defaults.ingSettingIsPermanent)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("Make changes to ingredient settings permanent")
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(K.textColor)
                    
                    
                }.frame(width: 300, height: 100)
                    .background(K.frameColor)
                    .cornerRadius(20)
                    .foregroundColor(K.textColor)
            }
            
            Spacer()
                .frame(height:30)
            
            Button(action: {
                defaults.set(false, forKey: K.Defaults.ingSettingIsPermanent)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("Make changes to ingredient settings temporary")
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(K.textColor)
                    
                    
                }.frame(width: 300, height: 100)
                    .background(K.frameColor)
                    .cornerRadius(20)
                    .foregroundColor(K.textColor)
            }
            
            Text("Current preference: \(defaults.bool(forKey: K.Defaults.ingSettingIsPermanent) ? "ingredient settings are permanent" : "ingredient settings are temporary")")
                .multilineTextAlignment(.center)
                .padding()
            
            
            Spacer()
                .frame(height: 30)
            
        }.navigationBarTitle("Ingredient Preferences", displayMode: .inline)
    }
}

struct SetIngredientPermanence_Previews: PreviewProvider {
    static var previews: some View {
        SetIngredientPermanence()
    }
}
