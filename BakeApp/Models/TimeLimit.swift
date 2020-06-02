//
//  TimeLimit.swift
//  BakeApp
//
//  Created by Alex Moran on 5/30/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation
import CoreData

public class TimeLimit:NSManagedObject, Identifiable {
    @NSManaged public var timeType:String?
    @NSManaged public var timeLength:Double
}

extension TimeLimit {
    static func getTimeValue() -> NSFetchRequest<TimeLimit> {
        let request:NSFetchRequest<TimeLimit> = TimeLimit.fetchRequest() as! NSFetchRequest<TimeLimit>
        
        let sortDescriptor = NSSortDescriptor(key: "timeType", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
