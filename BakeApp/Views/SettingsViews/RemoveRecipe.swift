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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    
    var userSettings = UserSettings()
    
    @State var showAlert = true
    
    @State private var practiceRecipes:[Recipe]? = recipeData
        .enumerated()
        .filter { !((defaults.array(forKey: K.Defaults.removedRecipeIndex) as! Array).contains($0.offset)) }
        .map { $0.element }
    
    @State var searchText:String = ""
    var body: some View {
        VStack{
            SearchBar(text: $searchText, placeholder: "Find recipe...")
            
            List {
                ForEach((practiceRecipes?.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }))!, id: \.self) { recipe in
                    NavigationLink(destination: RecipeDetail(recipe:recipe, practiceArray: self.$practiceRecipes, remove:true, deleteDelegate:self, goToIngSelect2: .constant(false))) {
                        RecipeTile(recipe: recipe)
                    }
                    
                }
            }
        }.navigationBarTitle("Remove Recipes")
            .onAppear(perform: {
                self.practiceRecipes = recipeData
                    .enumerated()
                    .filter { !(defaults.object(forKey: K.Defaults.removedRecipeIndex) as! Array).contains($0.offset) }
                    .map { $0.element }
                
            })
    }
    
    
    func externalDelete(recipe:String) {
        var index:Int?
        var recipeDataIndex:Int?
        for counter in 0..<practiceRecipes!.count {
            if recipe == practiceRecipes?[counter].name {
                print("found recipe to delete: \(practiceRecipes![counter].name)")
                index = counter
            }
        }
        
        for counter in 0..<recipeData.count {
            if recipe == recipeData[counter].name {
                recipeDataIndex = counter
            }
        }
        
        if let realIndex = index {
            print("found valid index...deleting recipe")
            userSettings.removedRecipeIndex.append(recipeDataIndex!)
            practiceRecipes?.remove(at: realIndex)
            print("recipe deleted")
        }
        
        //take care of ingredients
        let recipe = recipeData[recipeDataIndex!]
        print("Recipe: \(recipe.name)")
        for ing in recipe.sysIng {
            print("Proceeding for ingredient \(ing)")
            var ingredient:IngredientsOwned?
            
            for counter in 0..<self.ingStatus.count {
                print("Checking")
                if ingStatus[counter].ingredientName! == ing  {
                    ingredient = ingStatus[counter]
                    print("Found corresponding ingredient in CoreData")
                }
            }
            
            if (ingredient?.instances ?? 1) - 1 == 0 {
                ingredient?.setValue(true, forKey: "isHidden")
            }
            let instances = ingredient?.instances ?? 1
            ingredient?.setValue(instances-1, forKey: "instances")
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
            
        }
   
    }
}

struct RemoveRecipe_Previews: PreviewProvider {
    static var previews: some View {
        RemoveRecipe()
    }
}
