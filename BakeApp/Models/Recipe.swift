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
    
    var id: Int
    var name: String
    fileprivate var imageName: String
    var ingredients: [String]
    var instructions: [Instructions]
    var totalTime: Int
    var bakeTime: Int
    var prepTime: Int
    var type: String
    var sysIng: [String]
}

//pulls the image from Assets and includes it in Recipe
extension Recipe {
    var image: Image {
        Image(imageName)
    }
}

//converts the Integer values for totalTime, bakeTime, prepTime to natural language Strings
extension Recipe {
     func totTimeText() -> String {
        if (totalTime % 60) == 0 {
            if totalTime == 60 {
                       return String("1 hour")
            } else {
                return String("\(Int(floor(Double(totalTime) / 60))) hours")
            }
        } else {
        if  totalTime > 120 {
            return String("\(Int(floor(Double(totalTime) / 60))) hours, \(totalTime % 60) minutes")
        } else if  totalTime > 60 {
            return String("1 hour, \(totalTime % 60) minutes")
        }
        else {
            return String("\(totalTime) minutes")
        }
        }
    }
    
     func prepTimeText() -> String {
        if (prepTime % 60) == 0 {
            if prepTime == 60 {
                       return String("1 hour")
            } else {
                return String("\(Int(floor(Double(prepTime) / 60))) hours")
            }
        } else {
        if  prepTime > 120 {
            return String("\(Int(floor(Double(prepTime) / 60))) hours, \(prepTime % 60) minutes")
        } else if  prepTime > 60 {
            return String("1 hour, \(prepTime % 60) minutes")
        }
        else {
            return String("\(prepTime) minutes")
        }
        }
    }
    
     func bakeTimeText() -> String {
        if (bakeTime % 60) == 0 {
            if bakeTime == 60 {
                       return String("1 hour")
            } else {
                return String("\(Int(floor(Double(bakeTime) / 60))) hours")
            }
        } else {
        if  bakeTime > 120 {
            return String("\(Int(floor(Double(bakeTime) / 60))) hours, \(bakeTime % 60) minutes")
        } else if  bakeTime > 60 {
            return String("1 hour, \(bakeTime % 60) minutes")
        }
        else {
            return String("\(bakeTime) minutes")
        }
        }
    }
}

extension String {
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
}

//defines data structure for "Instructions" type in "Recipe"
struct Instructions: Hashable, Codable {
    var stepNum: Int
    var ins: String
    
}

