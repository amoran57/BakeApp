//
//  IngonHand.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/16/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation

struct SetUpIng: Hashable {
     
    
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
    
    //fills our dictionary with keys drawn from uniqueIng function and values of "true" in every case
    func createDict () -> [String:Bool] {
        //sets our dictionary which will have a bool for every unique ingredient
        var tempDict:[String:Bool] = [:]
        for item in 0..<SetUpIng.uniqueIng(list: recipeData).count {
            //initializes every ingredient to "true"
            tempDict[SetUpIng.uniqueIng(list: recipeData)[item]] = true
        }
        return tempDict
    }
    
    var dict: [String:Bool] {
        createDict()
    }
    
    static var list: [String] {
        uniqueIng(list: recipeData)
    }
    
    static var timeList:[String] = [K.Time.totalTime, K.Time.prepTime, K.Time.bakeTime]
    
//    let chunkedIng = uniqueIng(list: recipeData).chunked(into: 3)
}

