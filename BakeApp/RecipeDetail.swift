//
//  Recipe Detail.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct RecipeDetail: View {
    
    @State private var showingSheet = false
    var recipe: Recipe
    
    var body: some View {
        ScrollView{
        VStack {
            //tease preview
            CircleImage(image: recipe.image)
            
            //name of recipe
            Text(recipe.name)
                .foregroundColor(K.textColor)
                .font(.system(size: 32))
                .fontWeight(.bold)
            
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
            
            Button("Show sheet") {
                self.showingSheet.toggle()
            }.sheet(isPresented: $showingSheet) {
                ScrollInsPopup(recipe: self.recipe)
            }.padding(.bottom)
            
        }
        
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[5])
    }
}
