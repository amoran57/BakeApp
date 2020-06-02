//
//  FilterByTime.swift
//  BakeApp
//
//  Created by Alex Moran on 5/31/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import CoreData

struct FilterByTime {
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    var couldNotFilter:Bool = false
    var couldNotFilterByIng:Bool = false
    var couldNotFilterByTime:Bool = false
    let recipeScreener = RecipeScreener()
    
    mutating func filterByTime(ingredientData input:FetchedResults<IngredientsOwned>, timeData:FetchedResults<TimeLimit>) -> [Recipe] {
        //creates array of recipes to filter; this array is pre-filtered by ingredient
        let inputRecipes:[Recipe]? = recipeScreener.filterByIngredients(input:input)
        var validRecipes:[Recipe] = inputRecipes ?? recipeData
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
                //get the index number of that recipe in the recipeData array
                if let index = validRecipes.firstIndex(of: recipe) {
                    //remove the recipe at that index
                    validRecipes.remove(at: index)
                }
            } else if recipe.prepTime > Int(prepTime?.timeLength ?? 60) {
                //get the index number of that recipe in the recipeData array
                if let index = validRecipes.firstIndex(of: recipe) {
                    //remove the recipe at that index
                    validRecipes.remove(at: index)
                }
            }  else if recipe.bakeTime > Int(bakeTime?.timeLength ?? 60) {
                //get the index number of that recipe in the recipeData array
                if let index = validRecipes.firstIndex(of: recipe) {
                    //remove the recipe at that index
                    validRecipes.remove(at: index)
                }
            }
        }
        
        if inputRecipes != nil && validRecipes.count > 0  {
            print("Successfully filtered by both ingredients and time limits. \(validRecipes.count) recipes passed the filters!")
            couldNotFilter = false
            couldNotFilterByIng = false
            couldNotFilterByTime = false
            return validRecipes
        }
        else {
            if let filteredByIngredients = recipeScreener.filterByIngredients(input:input) {
                //if time limits are untenable, returns array only filtered by ingredients
                print("Filtered by ingredients, but was unable to filter by requested time limits. \(filteredByIngredients.count) recipes passed the filters!")
                couldNotFilterByTime = true
                couldNotFilter = false
                couldNotFilterByIng = false
                return filteredByIngredients
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
                return recipeData
            }
        }
    }
    
    mutating func randomIndex(ingredientData input:FetchedResults<IngredientsOwned>, timeData:FetchedResults<TimeLimit>) -> Recipe {
        let randNum = Int.random(in: 0..<filterByTime(ingredientData: input, timeData: timeData).count)
        print("Generated index number: \(randNum)")
        return filterByTime(ingredientData: input, timeData: timeData)[randNum]
    }
}
