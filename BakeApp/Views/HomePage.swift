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
    @State private var showingSheet = false
    
    @State var recipe:Recipe?
    
    var body: some View {
        return GeometryReader { geometry in
            
            NavigationView {
                VStack {
                    //button to go to random recipe; calls on global instance of FilterByTime
                    NavigationLink(
                        destination: RecipeDetail(recipe: self.recipe ?? recipeData[0])
                        )
                    {
                        Image(K.bakeButton)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: geometry.size.height/2.2, height: geometry.size.height/2.2)
                    }
                    
                    
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
                    
                   
                    
                }.frame(width:geometry.size.width, height:700)
                .navigationBarHidden(false)
                       .navigationBarItems(trailing: NavigationLink(destination:Settings()) {
                           Text("Settings")
                            .foregroundColor(K.blue)
                       }.frame(width: 375, alignment: .trailing)
                           .padding(.trailing))
                
            }
        }
            //when the view appears, initialize CoreData (function only runs if CoreData is empty)
            .onAppear {self.setCoreData(); print("These are the times: \(SetUpIng.temporaryTimes[0].timeType), \(SetUpIng.temporaryTimes[1].timeType), \(SetUpIng.temporaryTimes[2].timeType)")}
       
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
            //bonus: set default settings
            defaults.set(true, forKey: K.Defaults.primaryViewIsTile)
            
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
        
        for time in timeValue {
            SetUpIng.temporaryTimes.append(time)
        }
        
        for ing in ingStatus {
            SetUpIng.temporaryIngredients.append(ing)
        }
        
        self.recipe = filterByTime.randomIndex(ingredientData: self.ingStatus, timeData: SetUpIng.temporaryTimes)
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 8"], id: \.self) { deviceName in
            HomePage()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

