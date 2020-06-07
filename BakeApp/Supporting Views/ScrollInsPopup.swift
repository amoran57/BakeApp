//
//  ScrollInsPopup.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages

struct ScrollInsPopup: View {
    
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var recipe:Recipe
     @State var index: Int = 0
    var cars:[Int] {
        return Array(repeating: 0, count: recipe.instructions.count)
    }
    
    var body: some View {
        
        VStack {
            
            VStack {
            Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                        .padding(.top)
                        .padding(.leading)
                }
            }.frame(width: 375, alignment: .leading)
            
            Text("\(recipe.name)")
                .fontWeight(.semibold)
                .padding(.top, 50)
                .foregroundColor(K.textColor)
                .font(.title)
            
//            Spacer()
           
            
            ModelPages(recipe.instructions, currentPage: $index) { index, _  in
                StepByStep(index: index, recipe: self.recipe)
            }



        }
    }
}


struct ScrollInsPopup_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(recipeData, id: \.self) { recipe in
//        ScrollInsPopup(recipe: recipe)
//        }
        ScrollInsPopup(recipe: recipeData[0])
    }
}
