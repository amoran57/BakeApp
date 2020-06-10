//
//  RemoveRecipe.swift
//  BakeApp
//
//  Created by Alex Moran on 6/9/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct RemoveRecipe: View {
    @State var searchText:String = ""
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
            
            List(recipeData.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) })) { recipe in
                NavigationLink(destination: RecipeDetail(recipe:recipe, remove:true)) {
                RecipeTile(recipe: recipe)
                }
            }
            
            
            
        }
    }
    
//    func delete(at offsets: IndexSet) {
//        recipeData.remove(atOffsets: offsets)
//    }
}


struct TempView: View {
    @State private var users = ["Paul", "Taylor", "Adele"]

      var body: some View {
          NavigationView {
              List {
                  ForEach(users, id: \.self) { user in
                      Text(user)
                  }
                  .onDelete(perform: delete)
              }
          }
      }

      func delete(at offsets: IndexSet) {
          users.remove(atOffsets: offsets)
      }
}

struct RemoveRecipe_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
