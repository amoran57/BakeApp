//
//  IngredientsOwned.swift
//  BakeApp
//
//  Created by Alex Moran on 5/28/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation
import CoreData

public class IngredientsOwned:NSManagedObject, Identifiable {
    @NSManaged public var ingredientName:String?
    @NSManaged public var isOwned:Bool
    @NSManaged public var instances:Int16
}

extension IngredientsOwned {
    static func getAllIngStatus() -> NSFetchRequest<IngredientsOwned> {
        let request:NSFetchRequest<IngredientsOwned> = IngredientsOwned.fetchRequest() as! NSFetchRequest<IngredientsOwned>
        
        let sortDescriptor = NSSortDescriptor(key: "instances", ascending: false)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
