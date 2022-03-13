//
//  RecipeTop.swift
//  BakeApp
//
//  Created by Alex Moran on 4/28/21.
//  Copyright © 2021 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages

struct RecipeTop: View {
    var recipe:Recipe
    @State var index: Int = 0
    var body: some View {
        VStack {
            Text(recipe.name)
                .foregroundColor(K.textColor)
                .font(.system(size: 32))
                .fontWeight(.bold)
                .frame(width: 350)
                .lineLimit(1)
            
            
            
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
            
            Text("Yield: \(recipe.yield)")
                .foregroundColor(K.textColor)
                .font(.system(size: 12))
            
            HStack {
                Text("Recipe credit: \(recipe.credit)")
                    .italic()
                    .lineLimit(2)
                Text("Image credit: \(recipe.imageCredit)")
                    .italic()
                    .lineLimit(2)
            }
            .padding(.horizontal)
            .font(.system(size: 10))
            .foregroundColor(K.textColor)
            .frame(width: 400)
            .fixedSize()
            
            
            Spacer()
                .frame(height: 20.0)
            
            ModelPages(recipe.instructions, currentPage: $index
//                       , currentTintColor: K.UITextColor, tintColor: K.UIFrameColor
            )
            { index, _  in
                StepByStep(index: index, recipe: self.recipe)
            }.frame(minHeight: 500, maxHeight: .infinity)
                .padding(.top, -50)
        }
        .padding(.top, -40)
    }
}

struct RecipeTop_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTop(recipe: recipeData[1])
    }
}
