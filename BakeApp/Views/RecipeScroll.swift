//
//  RecipeScroll.swift
//  BakeApp
//
//  Created by Alex Moran on 4/28/21.
//  Copyright © 2021 Alex Moran. All rights reserved.
//

import SwiftUI

struct RecipeScroll: View {
    var recipe:Recipe
    var body: some View {
            
            //                    name of recipe
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
            IngList(ingList: self.recipe.ingredients, showDismiss: false, showSheet: .constant(false))
            
            Spacer()
                .frame(height: 20.0)
            
            //instructions
            InsList(insList: self.recipe.instructions, showDismiss: false, showSheet: .constant(false))

        }
        
    
}

//struct RecipeScroll_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeScroll()
//    }
//}
