//
//  ScrollInsPopup.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct ScrollInsPopup: View {
    
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var recipe:Recipe
    
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
           
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(alignment: .center, spacing: 50) {
                    ForEach(0...self.recipe.instructions.count-1, id: \.self) { index in
                        StepByStep(index:index, recipe:self.recipe)
                    }
                }
            }.padding(.bottom, 20)



        }
    }
}


struct ScrollInsPopup_Previews: PreviewProvider {
    static var previews: some View {
        ScrollInsPopup(recipe: recipeData[0])
    }
}
