//
//  Recipe Detail.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages

struct RecipeDetail: View {
    
    @State var index: Int = 0
    @State private var showingSheet = false
    @State private var showingSheet2 = false
    var recipe: Recipe
    var showSettings = true
    var primaryViewIsTile:Bool = defaults.bool(forKey: K.Defaults.primaryViewIsTile)
    
    var body: some View {
        
            VStack {
                if primaryViewIsTile {
                ScrollView {
                //tease preview
                CircleImage(image: recipe.image)
                
                //name of recipe
                Text(recipe.name)
                    .foregroundColor(K.textColor)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .frame(width: 350)
                .multilineTextAlignment(.center)
                
                //total time
                Text("Total time: \(recipe.totTimeText)")
                    .foregroundColor(K.textColor)
                    .font(.system(size: 20))
                
                //prep and bake times
                HStack {
                    Text("Prep time: \(recipe.prepTimeText)")
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.trailing)
                    Text("|")
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.center)
                    Text("Bake time: \(recipe.bakeTimeText)")
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.leading)
                }.font(.system(size: 12))
                    .frame(width: 400)
                    .fixedSize(horizontal: true, vertical: true)
                
                Spacer()
                    .frame(height: 20.0)
                
                    ModelPages(recipe.instructions, currentPage: $index, currentTintColor: K.UITextColor, tintColor: K.UIFrameColor) { index, _  in
                        StepByStep(index: index, recipe: self.recipe)
                    }.frame(minHeight: 500, maxHeight: .infinity)
                        .padding(.top, -50)
                }
                    HStack {
                        
                        Button("Show ingredients") {
                            self.showingSheet.toggle()
                        }.sheet(isPresented: $showingSheet) {
                        ScrollView {
                                IngList(ingList:self.recipe.ingredients, text: "\(self.recipe.name): Ingredients")
                                    .padding(.top)
                            }
                        }.padding(.bottom)
                            
                            
                            
                        
                        Spacer()
                            .frame(width: 75)
                        
                        Button("Show instructions") {
                            self.showingSheet2.toggle()
                        }.sheet(isPresented: $showingSheet2) {
                            ScrollView {
                                InsList(insList: self.recipe.instructions, text: "\(self.recipe.name): Instructions")
                                    .padding(.top)
                            }
                        }.padding(.bottom)
                    }
                   
        } else {
            ScrollView {
            //tease preview
            CircleImage(image: recipe.image)
            
            //name of recipe
            Text(recipe.name)
                .foregroundColor(K.textColor)
                .font(.system(size: 32))
                .fontWeight(.bold)
                .frame(width: 350)
            .multilineTextAlignment(.center)
            
            //total time
            Text("Total time: \(recipe.totTimeText)")
                .foregroundColor(K.textColor)
                .font(.system(size: 20))
            
            //prep and bake times
            HStack {
                Text("Prep time: \(recipe.prepTimeText)")
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.trailing)
                Text("|")
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                Text("Bake time: \(recipe.bakeTimeText)")
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.leading)
            }.font(.system(size: 12))
                .frame(width: 400)
                .fixedSize(horizontal: true, vertical: true)
            
            Spacer()
                .frame(height: 20.0)
              
                    //ingredients
                    IngList(ingList: self.recipe.ingredients)

                    Spacer()
                        .frame(height: 20.0)

                    //instructions
                    InsList(insList: self.recipe.instructions)
                    }
                    VStack {
                        Button(action: {
                            self.showingSheet.toggle()
                        }) {
                           Text("Show step-by-step detail")
                        }
                        .sheet(isPresented: $showingSheet) {
                            ScrollInsPopup(recipe: self.recipe)
                        }.padding(.bottom)
                    }.frame(width: 375, alignment: .trailing)
                        .padding(.trailing)
                
            }
        }.navigationBarTitle("\(recipe.name)", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: Settings()) {
                if showSettings {
            Text("Settings")
                }
        })
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[0])
    }
}
