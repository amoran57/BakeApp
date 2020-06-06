//
//  ScrollInsPopup.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct ScrollInsPopup: View {
    
    var recipe:Recipe
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height: 200)
            ScrollView(.horizontal, showsIndicators: false) {
                 
                HStack(alignment: .center, spacing: 50) {
                    
                    ForEach(0...self.recipe.instructions.count-1, id: \.self) { index in
                           
                            StepByStep(index:index, instructions:self.recipe.instructions)
                            
                        
                    }
                }
                }
            
            Spacer()
            
            
            HStack {
                Text("\(self.recipe.instructions.count) total steps")
            }.padding(.bottom)
        }
    }
}


struct ScrollInsPopup_Previews: PreviewProvider {
    static var previews: some View {
        ScrollInsPopup(recipe: recipeData[8])
    }
}
