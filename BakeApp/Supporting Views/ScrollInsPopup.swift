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
    var showDismiss:Bool = true
    var showTitle:Bool = true
    
    @State var index: Int = 0
    
    
    var body: some View {
        
        VStack {
            if showDismiss {
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Dismiss")
                            .padding(.top)
                            .padding(.trailing)
                    }
                }.frame(width: 375, alignment: .trailing)
            }
            
            if showTitle {
                Text("\(recipe.name)")
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                    .foregroundColor(K.textColor)
                    .font(.title)
            }
            
            
            ModelPages(recipe.instructions, currentPage: $index) { index, _  in
                StepByStep(index: index, recipe: self.recipe)
            }
            
        }
    }

}

//
//struct ScrollInsPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollInsPopup(recipe: recipeData[0])
//    }
//}
