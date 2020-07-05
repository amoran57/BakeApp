//
//  RecipeTile.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation
import URLImage


struct RecipeTile: View {
    var recipe: Recipe
    var remove:Bool = true
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if recipe.imageURL != nil {
                URLImage(URL(string: recipe.imageURL!)!) { proxy in
                    proxy.image
                        .resizable()
                        .frame(width: 104, height: 104)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                }
                
            } else {
                recipe.image
                    .resizable()
                    .frame(width: 104, height: 104)
                    .cornerRadius(10)
            }
            HStack {
                if recipe.isVegan {
                    Image(systemName: "v.circle.fill")
                        .foregroundColor(K.textColor)
                        .font(.system(size: 12))
                        .padding(.top, -5)
//                        .padding(.trailing, 2)
                }
                Text(recipe.name)
                    .foregroundColor(K.textColor)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .padding(.top, -5)
            }
        }.frame(width:111, height: 120)
    }
}

//struct RecipeTile_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeTile(recipe: recipeData[0])
//            .previewLayout(.fixed(width: 200, height: 200))
//    }
//}
