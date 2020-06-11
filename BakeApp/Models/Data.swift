//
//  Data.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//reads data from local JSON file, takes input of the file name
func load<T: Decodable>(_ filename:String) -> T {
    let data: Data

    //checks that such a file is in the bundle
    guard let file =
        Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle")
    }
    
    //creates a variable which safely pulls from the file
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
    }
    
    //decodes the safe variable
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//reads from the bundle file "recipeData.json" and sets the read value as an array of Recipe types
let recipeData: [Recipe] = load("recipeData.json")

