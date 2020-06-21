//
//  RestoreRecipe.swift
//  BakeApp
//
//  Created by Alex Moran on 6/11/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

protocol RestoreDelegate {
    func restoreRecipe(recipe:String)
}

struct RestoreRecipe: View, RestoreDelegate {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus(hideRemoved:false)) var ingStatus:FetchedResults<IngredientsOwned>
    
    var userSettings = UserSettings()
    @State var searchText:String = ""
    @State private var practiceRecipes:[Recipe]? = recipeData
        .enumerated()
        .filter { ((defaults.array(forKey: K.Defaults.removedRecipeIndex) as! Array).contains($0.offset)) }
        .map { $0.element }
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText, placeholder: "Find recipe...")
            
            List((practiceRecipes?.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }))!, id: \.self) { recipe in
                NavigationLink(destination: RecipeDetail(recipe:recipe, practiceArray: self.$practiceRecipes, restore:true, restoreDelegate:self, goToIngSelect2: .constant(false))) {
                    RecipeTile(recipe: recipe)
                }
                
            }
        }.navigationBarTitle("Restore Recipes")
            .onAppear(perform: {
                self.practiceRecipes = recipeData
                    .enumerated()
                    .filter { (defaults.object(forKey: K.Defaults.removedRecipeIndex) as! Array).contains($0.offset) }
                    .map { $0.element }
                
            })
    }
    
    func restoreRecipe(recipe:String) {
        var practiceRecipesIndex:Int?
        
        for counter in 0..<practiceRecipes!.count {
            if recipe == practiceRecipes?[counter].name {
                print("found recipe to delete: \(practiceRecipes![counter].name)")
                practiceRecipesIndex = counter
            }
        }
        
        
        var recipeDataIndex:Int?
        
        for counter in 0..<recipeData.count {
            if recipe == recipeData[counter].name {
                recipeDataIndex = counter
                print("recipeDataIndex is \(recipeDataIndex)")
            }
        }
        
        if let realIndex = recipeDataIndex {
            print("Real index is \(realIndex)")
            if let index = userSettings.removedRecipeIndex.firstIndex(of: realIndex) {
                userSettings.removedRecipeIndex.remove(at: index)
                 print("recipe restored")
            }
            
            if let practiceIndex = practiceRecipesIndex {
            practiceRecipes?.remove(at: practiceIndex)
                print("Recipe removed from deleted list")
            }
           
        }
        
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
            
            if ingredient != nil {
                ingredient!.setValue(false, forKey: "isHidden")
                let instances = ingredient!.instances
                ingredient!.setValue(instances+1, forKey: "instances")
            }
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
            
        }
    }
}



struct RestoreRecipe_Previews: PreviewProvider {
    static var previews: some View {
        RestoreRecipe()
    }
}
