//
//  SetRecipeDetailView.swift
//  BakeApp
//
//  Created by Alex Moran on 6/7/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct SetRecipeDetailView: View {
    
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
       
    
    var body: some View {
        VStack {
            Button(action: {
                defaults.set(true, forKey: K.Defaults.primaryViewIsTile)
                
                 self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("View Step-by-Step")
                        .font(.system(size:25))
                        .foregroundColor(K.textColor)
               
                    
                }.frame(width: 300, height: 100)
                    .cornerRadius(10)
                    .background(K.frameColor)
                    .foregroundColor(K.textColor)
            }
            
            Spacer()
                .frame(height: 50)
            
            Button(action: {
                defaults.set(false, forKey: K.Defaults.primaryViewIsTile)
                
                 self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("View all ingredients and instructions")
                        .font(.system(size:25))
                        .foregroundColor(K.textColor)
                    
                    
                  
                }.frame(width: 300, height: 100)
                    .cornerRadius(10)
                    .background(K.frameColor)
                    .foregroundColor(K.textColor)
                
                
            }
            
            Text("Permanent value: \(defaults.bool(forKey: K.Defaults.primaryViewIsTile).description)")
            
        }.navigationBarTitle("Recipe View Preferences")
    }
}

//struct SetRecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetRecipeDetailView()
//    }
//}

