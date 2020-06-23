//
//  Recipe.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import CoreLocation

//creates basic type "Recipe" which all recipes will conform to
struct Recipe: Codable, Identifiable, Hashable {
    
    var name: String
    var id: Int
    var yield: String
    var credit: String
    var materials: [String]
    fileprivate var imageName: String
    var imageCredit: String
    var ingredients: [String]
    var instructions: [String]
    var totalTime: Int
    var bakeTime: Int
    var prepTime: Int
    var type: String
    var sysIng: [String]
    var ingxins: [[Int]]
}

//pulls the image from Assets and includes it in Recipe
extension Recipe {
    var image: Image {
        Image(imageName)
    }
}


extension Recipe {
    func timeToText(time:Int) -> String {
        if (time % 60) == 0 {
            if time == 60 {
                return String("1 hour")
            } else {
                return String("\(Int(floor(Double(time) / 60))) hours")
            }
        } else {
            if  time > 120 {
                return String("\(Int(floor(Double(time) / 60))) hours, \(time % 60) minutes")
            } else if  time > 60 {
                return String("1 hour, \(time % 60) minutes")
            }
            else {
                return String("\(time) minutes")
            }
        }
    }
    
    var totTimeText:String {
        timeToText(time: totalTime)
    }
    
    var prepTimeText:String {
        timeToText(time: prepTime)
    }
    
    var bakeTimeText:String {
        timeToText(time: bakeTime)
    }
    
}
