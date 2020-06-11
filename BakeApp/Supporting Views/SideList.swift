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
    var filteredArray: [Recipe]
    
    func createNewArray() -> [Recipe]? {
        
        var recipeArray: [Recipe] = []
        for counter in 0..<filteredArray.count {
            if filteredArray[counter].type == self.typeOfBakedGood {
                recipeArray.append(filteredArray[counter])
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    
                    ForEach((filteredArray.filter({ $0.type.lowercased().contains(typeOfBakedGood.lowercased())})), id: \.self) {
                        recipe in
                        NavigationLink(destination:
                            RecipeDetail(recipe: recipe, practiceArray: .constant(nil), showSettings:false)
                        ) {
                            RecipeTile(recipe: recipe)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    
                    
//                    
//                    ForEach (self.createNewArray()!, id: \.self) { item in
//                        NavigationLink(destination:
//                            NavigationLazyView(RecipeDetail(recipe: item, practiceArray: .constant(nil), showSettings:false))
//                        ) {
//                            RecipeTile(recipe: item)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
                    
                }.padding(.trailing)
            }.edgesIgnoringSafeArea(.leading)
        }
    }
}


//struct SideList_Previews: PreviewProvider {
//    static var previews: some View {
//        SideList(typeOfBakedGood: "bread")
//    }
//}
