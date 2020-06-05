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
