//
//  FilterByTime.swift
//  BakeApp
//
//  Created by Alex Moran on 5/31/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import CoreData

class FilterByTime: ObservableObject {

    @Published var couldNotFilter:Bool = false
    @Published var couldNotFilterByIng:Bool = false
    @Published var couldNotFilterByTime:Bool = false
    
    let recipeScreener = RecipeScreener()
    
    func filterByTime(ingredientData input:FetchedResults<IngredientsOwned>, timeData:FetchedResults<TimeLimit>, recipeArray:[Recipe]) -> [Recipe] {
        //creates array of recipes to filter; this array is pre-filtered by ingredient
        let inputRecipes:[Recipe] = recipeScreener.filterByIngredients(input:input, recipeArray: recipeArray)
        
        var validRecipes = inputRecipes.count > 0 ? inputRecipes : recipeArray

        var totalTime:TimeLimit?
        var prepTime:TimeLimit?
        var bakeTime:TimeLimit?
        
        
        for time in timeData {
            if time.timeType == K.Time.totalTime {
                totalTime = time
            } else if time.timeType == K.Time.prepTime {
                prepTime = time
            } else if time.timeType == K.Time.bakeTime {
                bakeTime = time
            }
        }
        
        
        for recipe in validRecipes {
            if recipe.totalTime > Int(totalTime?.timeLength ?? 120) {
                //get the index number of that recipe in the array
                if let index = validRecipes.firstIndex(of: recipe) {
                    //remove the recipe at that index
                    validRecipes.remove(at: index)
                }
            } else if recipe.prepTime > Int(prepTime?.timeLength ?? 60) {
                //get the index number of that recipe in the array
                if let index = validRecipes.firstIndex(of: recipe) {
                    //remove the recipe at that index
                    validRecipes.remove(at: index)
                }
            }  else if recipe.bakeTime > Int(bakeTime?.timeLength ?? 60) {
                //get the index number of that recipe in the array
                if let index = validRecipes.firstIndex(of: recipe) {
                    //remove the recipe at that index
                    validRecipes.remove(at: index)
                }
            }
        }
        
        if inputRecipes.count > 0 && validRecipes.count > 0  {
            print("Successfully filtered by both ingredients and time limits. \(validRecipes.count) recipes passed the filters!")
            couldNotFilter = false
            couldNotFilterByIng = false
            couldNotFilterByTime = false
            return validRecipes
        }
        else {
            if inputRecipes.count > 0 {
                //if time limits are untenable, returns array only filtered by ingredients
                print("Filtered by ingredients, but was unable to filter by requested time limits. \(inputRecipes.count) recipes passed the filters!")
                couldNotFilterByTime = true
                couldNotFilter = false
                couldNotFilterByIng = false
                return inputRecipes
            } else if validRecipes.count > 0 {
                print("Filtered by time, but was unable to filter by ingredients. \(validRecipes.count) recipes passed the filters!")
                couldNotFilterByIng = true
                couldNotFilter = false
                couldNotFilterByTime = false
                return validRecipes
            }
            else {
                //failsafe: returns complete, original array
                print("Was unable to filter by either ingredients or time limits; returning full recipe array.")
                couldNotFilter = true
                couldNotFilterByIng = false
                couldNotFilterByTime = false
                return recipeArray
            }
        }
    }
    
    func randomIndex(ingredientData input:FetchedResults<IngredientsOwned>, timeData:FetchedResults<TimeLimit>, recipeArray:[Recipe]) -> Recipe {
        
        let filteredRecipeList = filterByTime(ingredientData: input, timeData: timeData, recipeArray: recipeArray)
        
        let randNum = Int.random(in: 0..<filteredRecipeList.count)
        print("Generated index number: \(randNum)")
        let returnedRecipe = filteredRecipeList[randNum]
        return returnedRecipe
    }
}
