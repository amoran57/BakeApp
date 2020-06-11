//
//  RemoveRecipe.swift
//  BakeApp
//
//  Created by Alex Moran on 6/9/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

protocol DeleteDelegate {
    func externalDelete(recipe:String)
}

struct RemoveRecipe: View, DeleteDelegate {
    
    @State private var practiceRecipes:[Recipe]? = load("recipeData.json")
    @State var searchText:String = ""
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
            
            List {
                ForEach((practiceRecipes?.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }))!, id: \.self) { recipe in
                    NavigationLink(destination: RecipeDetail(recipe:recipe, practiceArray: self.$practiceRecipes, remove:true, delegate:self)) {
                RecipeTile(recipe: recipe)
                }
                
                }.onDelete(perform: delete)
            }
        }
    }
    
//
//    .alert(isPresented:$showingAlert) {
//        Alert(title: Text("Are you sure you want to delete this?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
//    perform: delete
//        }, secondaryButton: .cancel())
//    }
    
    func delete(at offsets: IndexSet) {
        print("Deleted item")
        practiceRecipes?.remove(atOffsets: offsets)
    }
    
    func externalDelete(recipe:String) {
        var index:Int?
        for counter in 0..<practiceRecipes!.count {
            if recipe == practiceRecipes?[counter].name {
                print("found recipe to delete: \(practiceRecipes![counter].name)")
                index = counter
            }
        }
        if let realIndex = index {
            print("found valid index...deleting recipe")
        practiceRecipes?.remove(at: realIndex)
            print("recipe deleted")
        }
    }
    
}


struct TempView: View {
    @State private var users = ["Paul", "Taylor", "Adele"]

      var body: some View {
          NavigationView {
              List {
                  ForEach(users, id: \.self) { user in
                      Text(user)
                  }
                 
              }
          }
      }

      func delete(at offsets: IndexSet) {
          users.remove(atOffsets: offsets)
      }
}

struct RemoveRecipe_Previews: PreviewProvider {
    static var previews: some View {
       RemoveRecipe()
    }
}
