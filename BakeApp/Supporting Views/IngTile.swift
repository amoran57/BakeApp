//
//  PracticeTile.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI


struct IngTile: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>

    var name:String
    var ingredient:IngredientsOwned {
        self.ingStatus[self.ingStatus.firstIndex{$0.ingredientName == name}!]
    }
    
    var body: some View {
        
        Button(action: {
            //update value
            self.ingredient.setValue(!self.ingredient.isOwned, forKey: "isOwned")
            
            //save updated value to CoreData
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        })
        {
            if self.ingredient.isOwned  {
                //appearance if isOwned == true
                Text(self.ingredient.ingredientName!)
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    .background(K.frameColor)
                    .cornerRadius(10)
            } else {
                //appearance if isOwned == false
                Text(self.ingredient.ingredientName!)
                    .strikethrough()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical)
                    .background(K.blue)
                    .cornerRadius(10)
            }
        }
    }
}


struct IngTile_Previews: PreviewProvider {
    static var previews: some View {
        IngTile(name: "flour")
    }
}
