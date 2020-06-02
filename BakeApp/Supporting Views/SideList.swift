//
//  SideList.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/15/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct SideList: View, Hashable {
    var typeOfBakedGood: String
    
    
    func createNewArray() -> [Recipe]? {
        var recipeArray: [Recipe] = []
        for counter in 0..<recipeData.count {
            if recipeData[counter].type == self.typeOfBakedGood {
                recipeArray.append(recipeData[counter])
            }
        }
        return recipeArray
    }
    
    
    
    var body: some View {
        VStack {
            Text(typeOfBakedGood.capitalized)
                .foregroundColor(K.textColor)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .frame(width: 360, alignment: .leading)
                .padding(.leading, 10)
                .padding(.bottom, -6)
            
            ScrollView(.horizontal) {
                HStack() {
                    ForEach (self.createNewArray()!, id: \.self) { item in
                        
                        NavigationLink(destination:RecipeDetail(recipe: item)) {
                                RecipeTile(recipe: item)
                            }.buttonStyle(PlainButtonStyle())
                            }
                    }.padding(.leading)
                    }
        }
    }
    }


struct SideList_Previews: PreviewProvider {
    static var previews: some View {
        SideList(typeOfBakedGood: "bread")
    }
}
