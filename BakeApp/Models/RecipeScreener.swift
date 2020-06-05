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

    //this function is called EVERY TIME an IngTile is pressed. It performs this loop EVERY TIME!!!
    func missingIngredients(input:FetchedResults<IngredientsOwned>) -> [String]? {
        var missing:[String] = ["k"]
        for counter in 0..<input.count {
//            print("Looping through ingredients to find false values. Loop number: \(counter)")
            let ingredient = input[counter]
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
        
        //declaring this function allows us to stop the loop and move on to the next recipe
        //immediately when we remove a recipe from the list
        func checkIngInRecipe(missingIngArray:[String], recipe:Recipe) {
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
                        return
                    }
                }
            }
        }
        
        //check if there are any ingredients missing
        if let missingIngArray = self.missingIngredients(input:input) {
            //loop through each recipe in the system
            for recipe in recipeData {
                checkIngInRecipe(missingIngArray: missingIngArray, recipe: recipe)
            }
        }
        
        print("\(validRecipes.count) recipes passed the ingredients filter.")
        return validRecipes
        
    }
}



