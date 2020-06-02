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
            //fetch bool value

            self.trueFalse = self.ingStatus[self.counter].isOwned
            
            //toggle bool value
            if self.trueFalse! {
                self.trueFalse = false
            } else {
                self.trueFalse = true
            }
            
            //delete item from CoreData to prevent duplicate
            self.deleteItem(ingName: self.ingStatus[self.counter].ingredientName!)
            
            //create new item with desired value
            let ingredient = IngredientsOwned(context: self.managedObjectContext)
            ingredient.ingredientName = self.ingStatus[self.counter].ingredientName
            ingredient.isOwned = self.trueFalse!
            
            //save new item to CoreData
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
            
//            let deleteItem = self.ingStatus[14]
//            self.managedObjectContext.delete(deleteItem)
//
            if self.ingStatus.count == 0 {
            for ing in SetUpIng.list {
                self.deleteItem(ingName: ing)
                let ingredient = IngredientsOwned(context: self.managedObjectContext)
                ingredient.ingredientName = ing
                ingredient.isOwned = true
            }
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
                    .bold()
                    .foregroundColor(Color.white)
                    .strikethrough()
                    .padding()
                    .background(K.blue)
                    .cornerRadius(10)
            }
        }
    }
    
    func deleteItem(ingName:String) {
        var itemToDelete = false
        for counter in 0...self.ingStatus.count-1 {
            if self.ingStatus[counter].ingredientName?.lowercased() == ingName.lowercased() {
                let deleteItem = ingStatus[counter]
                itemToDelete = true
                self.managedObjectContext.delete(deleteItem)
            }
        }
        if !itemToDelete {
            print("Check your spelling; unable to delete requested item.")
        }
    }
}

