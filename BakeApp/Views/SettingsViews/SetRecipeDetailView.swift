////
////  SetRecipeDetailView.swift
////  BakeApp
////
////  Created by Alex Moran on 6/7/20.
////  Copyright © 2020 Alex Moran. All rights reserved.
////
//
//import SwiftUI
//
//struct SetRecipeDetailView: View {
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                defaults.set(true, forKey: K.Defaults.primaryViewIsTile)
//                
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                HStack {
//                    Text("View Step-by-Step by default")
//                        .padding()
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(K.textColor)
//                    
//                    
//                    
//                }.frame(width: 300, height: 100)
//                    .background(K.frameColor)
//                    .cornerRadius(20)
//                    .foregroundColor(K.textColor)
//            }
//            
//            Spacer()
//                .frame(height: 30)
//            
//            Button(action: {
//                defaults.set(false, forKey: K.Defaults.primaryViewIsTile)
//                
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                HStack {
//                    Text("View ingredients and instructions by default")
//                        .padding()
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(K.textColor)
//                    
//                    
//                    
//                    
//                }.frame(width: 300, height: 100)
//                    .background(K.frameColor)
//                    .cornerRadius(20)
//                    .foregroundColor(K.textColor)
//            }
//            
//            Text("Current preference: \(defaults.bool(forKey: K.Defaults.primaryViewIsTile) ? "view step-by-step" : "view ingredients and instructions")")
//                .padding(.top)
//                .foregroundColor(K.textColor)
//                .multilineTextAlignment(.center)
//            
//        }.navigationBarTitle("Recipe View Preferences", displayMode: .inline)
//    }
//}
//
//struct SetRecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetRecipeDetailView()
//    }
//}
//
