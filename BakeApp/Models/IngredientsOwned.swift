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
    @NSManaged public var isHidden:Bool
}

extension IngredientsOwned {
    static func getAllIngStatus(alphabetical:Bool = false, hideRemoved:Bool = true) -> NSFetchRequest<IngredientsOwned> {
        let request:NSFetchRequest<IngredientsOwned> = IngredientsOwned.fetchRequest() as! NSFetchRequest<IngredientsOwned>
        
        var sortDescriptor:NSSortDescriptor
        
        if hideRemoved {
            let predicate = NSPredicate(format: "isHidden != YES")
            request.predicate = predicate
        }
        
        if alphabetical {
            sortDescriptor = NSSortDescriptor(key: "ingredientName", ascending: true)
        } else {
            sortDescriptor = NSSortDescriptor(key: "instances", ascending: true)
        }
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}
