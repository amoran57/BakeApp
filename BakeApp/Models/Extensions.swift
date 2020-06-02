//
//  Extensions.swift
//  BakeApp
//
//  Created by Alex Moran on 5/28/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import Foundation


//creates a unique array while preserving the order
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

//sorts an array based on element frequency
extension Array where Element: Comparable & Hashable {
    func sortByNumberOfOccurences() -> [Element] {
        let occurencesDict = self.reduce(into: [Element:Int]()) { currentResult, element in
            currentResult[element, default: 0] += 1
        }
        return self.sorted(by: { current, next in occurencesDict[current]! > occurencesDict[next]!})
    }
}

//for the view in the future, we will want an array of certain-sized arrays of ingredients
//this code allows us to pass the unique array into a chunked array

extension Array {
func chunked(into size:Int) -> [[Element]] {
    
    var chunkedArray = [[Element]]()
    
    for index in 0...self.count {
        if index % size == 0 && index != 0 {
            chunkedArray.append(Array(self[(index - size)..<index]))
        } else if(index == self.count) {
            chunkedArray.append(Array(self[index - 1..<index]))
        }
    }
    
    return chunkedArray
}
}
