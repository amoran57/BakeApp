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
    
    func setSliderValue(input:Bool) -> Double? {
            var value:TimeLimit?
            var sliderSpot:Double?
            if sliderName == K.Time.totalTime {
                for counter in 0..<self.timeValue.count {
                    if timeValue[counter].timeType == K.Time.totalTime {
                        value = timeValue[counter]
                    }
                }
            } else if sliderName == K.Time.prepTime {
                for counter in 0..<self.timeValue.count {
                    if timeValue[counter].timeType == K.Time.prepTime {
                        value = timeValue[counter]
                    }
                }
            } else if sliderName == K.Time.bakeTime {
                for counter in 0..<self.timeValue.count {
                    if timeValue[counter].timeType == K.Time.bakeTime {
                        value = timeValue[counter]
                    }
                }
            }
        sliderSpot = value?.timeLength
        return sliderSpot
        
    }
    
    
    func deleteItem(item:String) {
        if item == K.Time.totalTime || item == K.Time.prepTime || item == K.Time.bakeTime {
            var itemToDelete = false
            if self.timeValue.count > 0 {
            for counter in 0...self.timeValue.count-1 {
                if self.timeValue[counter].timeType == item {
                    let deleteItem = self.timeValue[counter]
                    itemToDelete = true
                    self.managedObjectContext.delete(deleteItem)
                    print("Successfully deleted duplicate item.")
                }
            }
            if !itemToDelete {
                
                print("Could not find item to delete.")
            }
        } else {
            print("No duplicate to delete; proceeding to create new item.")
        }
        }
    }
    
    
    //the parent view will call this function when the continue button is pressed within the parent view
    func buttonPressed() {  //delete duplicate
        self.deleteItem(item: self.sliderName ?? K.Time.totalTime)
        
        //create item to add
        let timeLimit = TimeLimit(context: self.managedObjectContext)
        timeLimit.timeLength = self.sliderPosition/60
        timeLimit.timeType = self.sliderName ?? K.Time.totalTime
        
        //save new item
        do {
            try self.managedObjectContext.save()
            print("Successfully saved item.")
        } catch {
            print(error)
        }
    }
}

//    struct TimeSlider_Previews: PreviewProvider {
//        static var previews: some View {
//            TimeSlider()
//        }
//}
