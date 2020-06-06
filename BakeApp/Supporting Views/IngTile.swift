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
    
    var counter:Int
    @State private var trueFalse:Bool?
    
    var body: some View {
        
        Button(action: {
            
            let ingredient = self.ingStatus[self.counter]
            //fetch bool value
            self.trueFalse = ingredient.isOwned
            
            //toggle bool value
            self.trueFalse = !self.trueFalse!
            
            //update value
            ingredient.setValue(self.trueFalse, forKey: "isOwned")
            
            //save updated value to CoreData
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        })
        {
            if self.ingStatus[counter].isOwned  {
                //appearance if isOwned == true
                Text(self.ingStatus[counter].ingredientName!)
                    .foregroundColor(K.textColor)
                    .padding()
                    .background(K.frameColor)
                    .cornerRadius(10)
            } else {
                //appearance if isOwned == false
                Text(self.ingStatus[counter].ingredientName!)
                    .foregroundColor(Color.white)
                    .strikethrough()
                    .padding()
                    .background(K.blue)
                    .cornerRadius(10)
            }
        }
    }
}

