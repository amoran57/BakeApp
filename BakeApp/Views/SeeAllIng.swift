//
//  SeeAllIng.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct SeeAllIng: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus(alphabetical: true)) var ingStatus:FetchedResults<IngredientsOwned>
    
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var searchText:String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            
            List(ingStatus.filter({ searchText.isEmpty ? true : $0.ingredientName?.contains(searchText.lowercased()) as! Bool })) { ing in
                AllIngItem(ingredient: ing)
            }
        }.navigationBarTitle("Ingredients", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
                }
        )
    }
}
//
//struct SeeAllIng_Previews: PreviewProvider {
//    static var previews: some View {
//        SeeAllIng()
//    }
//}
