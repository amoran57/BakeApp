//
//  BakeButton.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct BakeButton: View {
    
    var recipeIndex:Int?
    
    var body: some View {
        return GeometryReader { geometry in
            NavigationLink(
                destination: RecipeDetail(recipe: recipeData[self.recipeIndex!])
            ) {
                Image(K.bakeButton)
                    .resizable()
                    .frame(width: geometry.size.height/3, height: geometry.size.height/3)
            }
        }
    }
}

struct BakeButton_Previews: PreviewProvider {
    static var previews: some View {
        BakeButton()
    }
}
