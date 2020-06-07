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
    var primaryViewIsTile:Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                //tease preview
                CircleImage(image: recipe.image)
                
                //name of recipe
                Text(recipe.name)
                    .foregroundColor(K.textColor)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
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
                
                if primaryViewIsTile {
                    ModelPages(recipe.instructions, currentPage: $index) { index, _  in
                        StepByStep(index: index, recipe: self.recipe)
                    }.frame(minHeight: 500, maxHeight: .infinity)
                        .padding(.top, -50)
                    
                    HStack {
                        
                        Button("Show all ingredients") {
                            self.showingSheet.toggle()
                        }.sheet(isPresented: $showingSheet) {
                            ScrollView {
                                IngList(ingList:self.recipe.ingredients)
                                    .padding(.top)
                            }
                        }.padding(.bottom)
                        
                        
                        Button("Show all instructions") {
                            self.showingSheet2.toggle()
                        }.sheet(isPresented: $showingSheet2) {
                            ScrollView {
                                InsList(insList: self.recipe.instructions)
                                    .padding(.top)
                            }
                        }.padding(.bottom)
                    }
                    
                } else {
                    //ingredients
                    IngList(ingList: self.recipe.ingredients)
                    
                    Spacer()
                        .frame(height: 20.0)
                    
                    //instructions
                    InsList(insList: self.recipe.instructions)
                    
                    VStack {
                        Button(action: {
                            self.showingSheet.toggle()
                        }) {
                            HStack {
                           Text("Show step-by-step detail")
                                Image(systemName: "arrow.right")
                            }
                        }
                        .sheet(isPresented: $showingSheet) {
                            ScrollInsPopup(recipe: self.recipe)
                        }.padding(.bottom)
                    }.frame(width: 375, alignment: .trailing)
                        .padding(.trailing)
                }
            }
        }.navigationBarTitle("\(recipe.name)", displayMode: .inline)
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[0])
    }
}
