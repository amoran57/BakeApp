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


struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}


struct HomePage: View {
    //fetch CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    
    
    var body: some View {
        return GeometryReader { geometry in
            
            NavigationView {
                VStack {
                    
                    
                    //button to go to random recipe; calls on global instance of FilterByTime
                    NavigationLink(
                        destination: NavigationLazyView(RecipeDetail(recipe: filterByTime.randomIndex(ingredientData: self.ingStatus, timeData: self.timeValue))))
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
            .onAppear {self.setCoreData()}
        
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
            
//            defaults.set(true, forKey: K.Defaults.primaryViewIsTile)
//            defaults.set(true, forKey: K.Defaults.ingSettingIsPermanent)
//            defaults.set(true, forKey: K.Defaults.timeSettingIsPermanent)
            
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
        
        
        if !defaults.bool(forKey: K.Defaults.ingSettingIsPermanent) {
            for ing in self.ingStatus {
                ing.setValue(true, forKey: "isOwned")
            }
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        
        if !defaults.bool(forKey: K.Defaults.timeSettingIsPermanent) {
            
            var totalTime:TimeLimit?
            var prepTime:TimeLimit?
            var bakeTime:TimeLimit?
            
            for time in self.timeValue {
                if time.timeType == K.Time.totalTime {
                    totalTime = time
                } else if time.timeType == K.Time.prepTime {
                    prepTime = time
                } else if time.timeType == K.Time.bakeTime {
                    bakeTime = time
                }
            }
            totalTime?.setValue(300, forKey: "timeLength")
            prepTime?.setValue(300, forKey: "timeLength")
            bakeTime?.setValue(300, forKey: "timeLength")
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        
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

