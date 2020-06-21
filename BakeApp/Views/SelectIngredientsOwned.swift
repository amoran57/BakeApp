//
//  PracticeIngList.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import UIKit

//This is the ingredient selection page, where users can indicate whether they are missing certain ingredients

struct SelectIngredientsOwned: View {
    
    //CoreData setup
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    //setup for custom back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var showSettings = true
    var goToHomePage = false
    
    //number of tiles per line
    var numPerLine:Int? = 3
    
    var body: some View {
        return GeometryReader { geometry in
            
            VStack {
                
                //body of view
                ScrollView {
                    VStack {
                        ForEach(0..<5) { number in
                            //returns HStacks of length numPerLine
                            HStack {
                                ForEach(self.thirdNumber(number:number)..<self.fourthNumber(number:number)) { counter in
                                    if counter < self.ingStatus.count {
                                        IngTile(counter: counter)
                                            .padding(5)
                                            .padding(.trailing,0)
                                    }
                                }
                            }
                        }
                    }
                }
                
                ZStack {
                    if filterByTime.couldNotFilter {
                        Text("None of our recipes fit either your time limits or your ingredient specifications.")
                    } else if filterByTime.couldNotFilterByIng {
                        Text("We couldn't find a recipe with your ingredient specifications!")
                    } else if filterByTime.couldNotFilterByTime {
                        Text("We've got a recipe that fit your ingredient specifications, but not your requested time limits.")
                    }  else {
                        Text("Ready to generate your recipe!")
                    }
                }.font(.system(size:12))
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 100, alignment: .center)
                
                //continue button
                HStack {
                    NavigationLink(destination: SeeAllIng(searchText: "", showSettings: self.showSettings)) {
                        Text("See all ingredients")
                    }
                    
                    Spacer()
                    if self.goToHomePage {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                        {
                            HStack{
                            Text("Continue")
                                Image(systemName: "arrow.right")
                            }
                                .foregroundColor(K.blue)
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                    
                }.padding(.bottom)
                    .padding(.horizontal)
                
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .navigationBarTitle("Missing Ingredients")
                .navigationBarItems(trailing:
                    NavigationLink(destination:Settings()) {
                        if self.showSettings {
                            Text("Settings")
                        }
                    }
            )
        }
    }
    //functions to calculate the grid-style view of ingredient tiles
    func secondNumber() -> Int {
        let secondNumber = ((self.ingStatus.count-1)/numPerLine!)+1
        return secondNumber
    }
    
    func thirdNumber(number:Int) -> Int {
        let thirdNumber = (1+numPerLine!*number)-1
        return thirdNumber
    }
    
    func fourthNumber(number:Int) -> Int {
        let fourthNumber = numPerLine! + numPerLine!*number
        return fourthNumber
    }
}
