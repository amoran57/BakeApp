//
//  AllIngItem.swift
//  BakeApp
//
//  Created by Alex Moran on 6/8/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct AllIngItem: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    var ingredient:IngredientsOwned
    @State private var trueFalse:Bool?
    
    var body: some View {
        
        Button(action: {
            //fetch bool value
            self.trueFalse = self.ingredient.isOwned
            
            //toggle bool value
            self.trueFalse = !self.trueFalse!
            
            //update value
            self.ingredient.setValue(self.trueFalse, forKey: "isOwned")
            
            //save updated value to CoreData
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        })
        {
            HStack {
                if trueFalse ?? ingredient.isOwned {
                    Text("\(self.ingredient.ingredientName!)")
                } else {
                    Text("\(self.ingredient.ingredientName!)")
                        .strikethrough()
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(K.textColor)
        }
    }
}

//struct AllIngItem_Previews: PreviewProvider {
//    static var previews: some View {
//        AllIngItem()
//    }
//}
