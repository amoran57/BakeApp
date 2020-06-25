//
//  TimeSlider.swift
//  BakeApp
//
//  Created by Alex Moran on 5/30/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct TimeSlider: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    
    var sliderName:String
    @State var sliderPosition:Double
    
    let formatter = DateComponentsFormatter()
    
    var body: some View {
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        
        return VStack {
            Text(sliderName)
                .font(.system(size: 24))
                .foregroundColor(K.textColor)
            Slider(value: $sliderPosition, in: 0...18000, step: 900, onEditingChanged: {_ in
                self.buttonPressed()
            })
                .frame(width: 300)
            Text(formatter.string(from: TimeInterval(sliderPosition))!)
                .font(.system(size: 16))
                .foregroundColor(K.textColor)
        }
    }
  
    func buttonPressed() {
        //identify current slider
        for counter in 0...self.timeValue.count-1 {
            if self.timeValue[counter].timeType == self.sliderName {
                //create constants to represent current slider and current value
                let currentSlider = self.timeValue[counter]
                let updateVal = self.sliderPosition/60
                //update the appropriate ManagedObject in the context
                currentSlider.setValue(updateVal, forKey: "timeLength")
                
                //push changes to CoreData
                do {
                    try self.managedObjectContext.save()
//                    print("Successfully saved item: \(self.timeValue[counter].timeType) for value \(self.timeValue[counter].timeLength)")
                } catch {
                    print(error)
                }
            }
            }
        
    }
}
