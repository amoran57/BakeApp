//
//  IngonHand.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/16/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation

struct SetUpIng: Hashable {
     
    static let userSettings = UserSettings()
    
    static let filteredArray = recipeData
    .enumerated()
        .filter { !(userSettings.removedRecipeIndex.contains($0.offset)) }
    .map { $0.element }
    
    static func AllIng (list: [Recipe]) -> [String] {
        //creates the non-unique string array and the unique one
        var unIng:[String] = []
        //fills it with the ingredients from every recipe
        ///loops through every recipe
        for counter1 in 0..<list.count {
            ///for every recipe, loops through "sysIng" array
            for counter2 in 0..<list[counter1].sysIng.count {
                unIng.append(list[counter1].sysIng[counter2])
            }
        }
        //now we have an array with each ingredient. But we want each ingredient in order of frequency, and only once
        return unIng
    }
    //extract an array of only the unique "sysIng" items
    static func uniqueIng (list: [Recipe]) -> [String] {
        //creates the non-unique string array and the unique one
        var unIng:[String] = []
        //fills it with the ingredients from every recipe
        ///loops through every recipe
        for counter1 in 0..<list.count {
            ///for every recipe, loops through "sysIng" array
            for counter2 in 0..<list[counter1].sysIng.count {
                unIng.append(list[counter1].sysIng[counter2])
            }
        }
        //now we have an array with each ingredient. But we want each ingredient in order of frequency, and only once
        return (unIng.sortByNumberOfOccurences()).unique()
    }
    
    static var list: [String] {
        uniqueIng(list: recipeData)
    }
    
    static var timeList:[String] = [K.Time.totalTime, K.Time.prepTime, K.Time.bakeTime]
    
    static var firstOpen:Bool = true
}
