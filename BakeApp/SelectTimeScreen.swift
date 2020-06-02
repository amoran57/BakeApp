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
    
    var setData:Bool?
    
    //this function only runs the first time the app is used, and initializes the CoreData
    //for each ingredient, setting each ingredient's isOwned value to true
    func setCoreData() {
        //only runs if passed by parent view HomePage
        if self.setData ?? false {
            //double-checks that CoreData is empty before proceeding
            if self.timeValue.count == 0 {
                for time in SetUpIng.timeList {
                    let timeLimit = TimeLimit(context: self.managedObjectContext)
                    timeLimit.timeType = time
                    timeLimit.timeLength = 300
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    var body: some View {
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        setCoreData()
        
        return GeometryReader { geometry in
            VStack {
                
                
                Text("Set your preferred time limits:")
                    .font(.system(size:28))
                    .foregroundColor(K.textColor)
                    .padding(.top, -50)
                
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
                        Text("No recipes matched either your time limits or ingredient specifications.")
                    } else if filterByTime.couldNotFilterByIng {
                        Text("We were able to find a recipe within your time limits, but were unable to filter by your ingredient specifications.")
                    } else if filterByTime.couldNotFilterByTime {
                        Text("We were able to find a recipe with your ingredient specifications, but were unable to filter by your requested time limits.")
                    } else {
                        Text("Ready to generate your recipe!")
                    }
                }.font(.system(size:12))
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: geometry.size.height/12, alignment: .center)
                
                //continue button
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }.foregroundColor(K.blue)
                    }.buttonStyle(PlainButtonStyle())
                    
                }.padding(.leading, geometry.size.width - 140)
                    .padding(.top)
                
            }
        }
    }
}

//struct SelectTimeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectTimeScreen()
//    }
//}
