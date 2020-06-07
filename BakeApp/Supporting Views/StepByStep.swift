//
//  StepByStep.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct StepByStep: View {
    
    var index:Int
    var recipe:Recipe
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Text("Step \(index+1):")
                    .foregroundColor(K.textColor)
                    .bold()
                    .font(.system(size:24))
                    .padding(.top)
                
                HStack {
                    if recipe.ingxins[self.index].count > 0 {
                        VStack {
                            ForEach(0..<recipe.ingxins[self.index].count) { ing in
                                
                                Text("\(self.recipe.ingredients[self.recipe.ingxins[self.index][ing]])")
                                    .foregroundColor(K.textColor)
                                    .multilineTextAlignment(.center)
                                if ing != self.recipe.ingxins[self.index].count-1 {
                                Divider()
                                    .background(K.textColor)
                                }
                            }
                        }.padding(.leading)
                        
                        
                        Divider()
                            .background(K.textColor)
                        
                    }
                    if recipe.ingxins[self.index].count > 0 {
                        Text(self.recipe.instructions[self.index])
                            .foregroundColor(K.textColor)
                            .padding(.horizontal, 5)
                            .frame(minWidth: 180)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(self.recipe.instructions[self.index])
                            .foregroundColor(K.textColor)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(.bottom)
                
            }
            .frame(width: 325)
            .fixedSize(horizontal: false, vertical: true)
            .background(K.frameColor)
            .cornerRadius(20)
            
        }
        .frame(width: 375)
        .fixedSize(horizontal:false, vertical:true)
        
    }
}

struct StepByStep_Previews: PreviewProvider {
    static var previews: some View {
        StepByStep(index:0, recipe: recipeData[1])
    }
}
