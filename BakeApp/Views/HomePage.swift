//
//  HomePage.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import URLImage

//create globally accessible instance of FilterByTime
var filterByTime = FilterByTime()
var errorLoadingCoreData:Bool = false

struct HomePage: View {
    //fetch CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    @FetchRequest(fetchRequest: TimeLimit.getTimeValue()) var timeValue:FetchedResults<TimeLimit>
    
    //hidden NavigationLink variables
    @State var navigationLinkActive:Bool = false
    @State var goToIngSelect = false
    
    var body: some View {
        return GeometryReader { geometry in
            NavigationView {
                VStack {
                    NavigationLink("",destination: SelectIngredientsOwned(geo: geometry.size.height), isActive: self.$goToIngSelect)
                    
                    NavigationLink(
                        "", destination:
                        RecipeDetail(
                            fromHomePage: true,
                            recipe: filterByTime
                                .randomIndex(ingredientData: self.ingStatus, timeData: self.timeValue,
                                             recipeArray: recipeData
                                                .enumerated()
                                                .filter { !(defaults.object(forKey: K.Defaults.removedRecipeIndex) as? Array ?? []).contains($0.offset) }
                                                .map { $0.element }),
                            practiceArray: .constant(nil),
                            goToIngSelect2: self.$goToIngSelect
                        ),
                        isActive: self.$navigationLinkActive
                    )
                    
                    Button(action: {
                        self.navigationLinkActive = true
                    })
                    {
                        Image(K.bakeButton)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: geometry.size.height/2.2, height: geometry.size.height/2.2)
                    }.padding(.top, -50)
                    
                    //status label
                    ZStack {
                        if filterByTime.couldNotFilter {
                            Text("None of our recipes fit either your time limits or your ingredient specifications.")
                        } else if filterByTime.couldNotFilterByIng {
                            Text("We've got a recipe that fits your time limits, but not your ingredient specifications.")
                        } else if filterByTime.couldNotFilterByTime {
                            Text("We've got a recipe that fit your ingredient specifications, but not your requested time limits.")
                        } else {
                            Text("We've got a recipe for you--click the button to bake!")
                        }
                    }
                    .font(.system(size:12))
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: geometry.size.height/12, alignment: .center)
                    
                    //link to ingredients selection page (SelectIngredientsOwned)
                    NavigationLink(destination: SelectIngredientsOwned(geo:geometry.size.height)) {
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
                .frame(height:750)
                .background(BackgroundView())
                .navigationBarItems(
                    leading:
                    NavigationLink(destination: HelpView()) {
                        Image(systemName: "questionmark.circle")
                        .resizable()
                            .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        
                    },
                    trailing: NavigationLink(destination:Settings()) {
                        Text("Settings")
                })
                    .overlay(
                        Group {
                            if errorLoadingCoreData {
                                ZStack {
                                    Text("We couldn't load your previous ingredient or time preferences. The app will still work, we just won't be able to account for your preferences. Swipe down to dismiss.")
                                        .frame(width: 300)
                                        .multilineTextAlignment(.center)
                                }.frame(width: 500, height: 1000, alignment: .center)
                                    .background(Color.black.opacity(0.8))
                            } else {
                                EmptyView()
                            }
                    })
            }
            //end GeometryReader
        }
            //when the view appears, initialize CoreData (function only runs if CoreData is empty)
            .onAppear (perform: {self.setCoreData()})
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
                ingredient.isHidden = false
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
            
            defaults.set(true, forKey: K.Defaults.primaryViewIsTile)
            defaults.set(true, forKey: K.Defaults.ingSettingIsPermanent)
            defaults.set(true, forKey: K.Defaults.timeSettingIsPermanent)
            defaults.set([], forKey: K.Defaults.removedRecipeIndex)
            
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
        
        //reset ingredients if needed
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
        
        //reset times if needed
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
        
        
        //for some reason I needed this to jolt the background view into action
        let ingredient = self.ingStatus[0]
        
        func toggleVal() {
            ingredient.setValue(!ingredient.isOwned, forKey: "isOwned")
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            toggleVal()
            toggleVal()
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

