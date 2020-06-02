//
//  HomePage.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

var filterByTime = FilterByTime()

struct HomePage: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    
    @State var activeImageIndex = Int.random(in: 0...recipeData.count-1) // Index of the currently displayed image
    
    let imageSwitchTimer = Timer.publish(every: 3, on: .main, in: .common)
        .autoconnect()
    
    var lackIngData:Bool { self.ingStatus.count == 0 }
    
    var lackTimeData:Bool {self.timeValue.count == 0}
    
    @Binding var returnedFromIngSelect:Bool?
    var returnedFromTimeSelect:Bool?
   
    //the chosen recipe will always show up, even when you toggle
    //repeatedly between views. This may actually be a good thing?
    
    var body: some View {
        
        return GeometryReader { geometry in
            NavigationView {
                VStack {
                    recipeData[self.activeImageIndex].image
                        .resizable()
                        .frame(width: 500, height: 500)
                        .clipShape(Circle())
                        .padding(.top, -450)
                        .shadow(radius: 10)
                        .onReceive(self.imageSwitchTimer) { _ in
                        // Go to the next image.
                        self.activeImageIndex = Int.random(in: 0...recipeData.count-1)
                    }
                    

                    
                    ZStack {
                        if self.returnedFromIngSelect ?? false {
                            Text("Ingredient filters applied!")
                        } else if self.returnedFromTimeSelect ?? false {
                            Text("Time filters applied!")
                        }
                    }.frame(height: geometry.size.height/24)
                    
                    NavigationLink(
                        destination: RecipeDetail(recipe: filterByTime.randomIndex(ingredientData: self.ingStatus, timeData: self.timeValue))
                    )
                    {
                        Image(K.bakeButton)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: geometry.size.height/2.6, height: geometry.size.height/2.6)
                    }
                    
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
                    
                    if !(self.returnedFromIngSelect ?? false) {
                        NavigationLink(destination: SelectIngredientsOwned(setData: self.lackIngData)) {
                            RectangleButton(text:"I'm short on ingredients.")
                        }
                    }
                    
                    if !(self.returnedFromTimeSelect ?? false) {
                        NavigationLink(destination: SelectTimeScreen(setData: self.lackTimeData)) {
                            RectangleButton(text:"I'm short on time.")
                        }
                    }
                    
                    NavigationLink(destination:RecipeList()) {
                        Text("I have something specific in mind.")
                            .font(.system(size:16))
                            .italic()
                            .underline()
                            .foregroundColor(K.textColor)
                    }
                    
                }.navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 8", "iPhone 11"], id: \.self) { deviceName in
            HomePage(returnedFromIngSelect: Binding.constant(false))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
