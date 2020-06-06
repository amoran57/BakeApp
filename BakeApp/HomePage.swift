//
//  HomePage.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

//create globally accessible instance of FilterByTime
var filterByTime = FilterByTime()

struct HomePage: View {
    //fetch CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    
    //slideshow:
    @State var activeImageIndex = Int.random(in: 0...recipeData.count-1) // Index of the currently displayed image
    let imageSwitchTimer = Timer.publish(every: 3, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        return GeometryReader { geometry in
            
            NavigationView {
                VStack {
                    //image slideshow on top
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
                    
                    
                   Spacer()
                    .frame(height: geometry.size.height/24)
                    
                    //button to go to random recipe; calls on global instance of FilterByTime
                    NavigationLink(
                        destination: RecipeDetail(recipe: filterByTime.randomIndex(ingredientData: self.ingStatus, timeData: self.timeValue))
                        )
                    {
                        Image(K.bakeButton)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: geometry.size.height/2.6, height: geometry.size.height/2.6)
                    }.animation(.easeIn(duration: 5))
                    
                    //status label
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
                    }
                    .font(.system(size:12))
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: geometry.size.height/12, alignment: .center)
                    
                    //link to ingredients selection page (SelectIngredientsOwned)
                        NavigationLink(destination: SelectIngredientsOwned()) {
                            RectangleButton(text:"I'm short on ingredients.")
                        }
                 
                   //link to time selection page (SelectTImeScreen)
                        NavigationLink(destination: SelectTimeScreen()) {
                            RectangleButton(text:"I'm short on time.")
                        }
                    
                    //link to recipe browse (RecipeList)
                    NavigationLink(destination:RecipeList()) {
                        Text("I have something specific in mind.")
                            .font(.system(size:16))
                            .italic()
                            .underline()
                            .foregroundColor(K.textColor)
                    }
                    
                }
            }
        }
        //when the view appears, initialize CoreData (function only runs if CoreData is empty)
        .onAppear(perform: setCoreData)
    }
    
    func setCoreData() {
        //double-checks that CoreData ingredient entity is empty before proceeding
        if self.ingStatus.count == 0 {
            //draw from the list of unique ingredients in SetUpIng singleton
            for ing in SetUpIng.list {
                //initialize ingredient
                let ingredient = IngredientsOwned(context: self.managedObjectContext)
                //set ingredient name
                ingredient.ingredientName = ing
                //assume that all ingredients are owned
                ingredient.isOwned = true
                //find frequency and store as "occurences" value
                var occurences:Int16 = 0
                
                for counter in 0..<SetUpIng.AllIng(list: recipeData).count {
                    let ingName = SetUpIng.AllIng(list: recipeData)[counter]
                    if ingName == ing {
                        occurences += 1
                    }
                }
                //set ingredient instances to match frequency
                ingredient.instances = occurences
                //save ingredient ManagedObject, or throw an error
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
        
        //repeat the process for CoreData time limit entity:
        
        //check that the entity is empty
        if self.timeValue.count == 0 {
            //draw from the list of unique time types in SetUpIng singleton
            for time in SetUpIng.timeList {
                //initialize time limit
                let timeLimit = TimeLimit(context: self.managedObjectContext)
                //initialize time type
                timeLimit.timeType = time
                //initialize time value to 5 hours by default
                timeLimit.timeLength = 300
                //save time ManagedObject, or throw an error
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
                
            }
            
        }

    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 8", "iPhone 11"], id: \.self) { deviceName in
            HomePage()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
