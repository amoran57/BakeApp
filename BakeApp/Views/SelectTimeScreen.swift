//
//  SelectTimeScreen.swift
//  BakeApp
//
//  Created by Alex Moran on 5/30/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct SelectTimeScreen: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let formatter = DateComponentsFormatter()
    var showSettings = true
    var isPermanent = false
    
    var body: some View {
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        
        return GeometryReader { geometry in
            VStack {
                Text("Set your preferred time limits:")
                    .font(.system(size:28))
                    .foregroundColor(K.textColor)
                
                Spacer()
                    .frame(height: 30)
                
                ForEach(0..<self.timeValue.count) { number in
                    TimeSlider(sliderName: self.timeValue[number].timeType ?? K.Time.totalTime, sliderPosition: self.timeValue[number].timeLength*60)
                    Spacer()
                        .frame(height: 30)
                }
                
                //warning view
                ZStack {
                    if filterByTime.couldNotFilter {
                        Text("None of our recipes fit either your time limits or your ingredient specifications.")
                    } else if filterByTime.couldNotFilterByIng {
                        Text("We've got a recipe that fits your time limits, but not your ingredient specifications.")
                    } else if filterByTime.couldNotFilterByTime {
                        Text("We couldn't find a recipe within your requested time limits!")
                    }  else {
                        Text("Ready to generate your recipe!")
                    }
                }.font(.system(size:12))
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: geometry.size.height/12, alignment: .center)
                
                Spacer()
                
            }.navigationBarItems(trailing:
                Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}


