//
//  RecipeScreener.swift
//  BakeApp
//
//  Created by Alex Moran on 5/30/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import CoreData

struct RecipeScreener {
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    
    func missingIngredients(input:FetchedResults<IngredientsOwned>) -> [String]? {
        var missing:[String] = ["k"]
        for counter in 0..<input.count {
//            print("Looping through ingredients to find false values. Loop number: \(counter)")
            let ingredient = input[counter]
//            print("Currently checking bool value for ingredient: \(ingredient.ingredientName ?? "this ingredient has no name") has a value of \(ingredient.isOwned)")
            if ingredient.isOwned == false {
                print("We don't have \(ingredient.ingredientName ?? "nameless ingredient")")
                if missing[0] == "k" {
                    missing[0] = (ingredient.ingredientName!)
                } else {
                    missing.append(ingredient.ingredientName!)
                }
                print("Current array of missing ingredients: \(missing)")
            }
        }
        print("Successfully created array of missing ingredients: \(missing)")
        return missing
    }
    
    func filterByIngredients(input:FetchedResults<IngredientsOwned>) -> [Recipe]? {
        var validRecipes:[Recipe] = recipeData
        //check if there are any ingredients missing
        if let missingIngArray = self.missingIngredients(input:input) {
            //loop through each recipe in the system
            for recipe in recipeData {
                //for each recipe, loop through the ingredients
                for ingRequired in recipe.sysIng {
                    //for each ingredient, loop it against the missing ingredients
                    for ingMissing in missingIngArray {
                        //check if the recipe has that ingredient
                        if ingMissing.lowercased() == ingRequired.lowercased() {
                            print("\(ingRequired) is required for recipe \(recipe.name), but that ingredient is not on hand.")
                            //get the index number of that recipe in the recipeData array
                            if let index = validRecipes.firstIndex(of: recipe) {
                                //remove the recipe at that index
                                validRecipes.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
        if validRecipes.count > 0 {
            print("\(validRecipes.count) recipes passed the ingredients filter.")
            return validRecipes
        } else {
            print("No recipes passed the ingredients filter.")
            return nil
        }
    }
}



