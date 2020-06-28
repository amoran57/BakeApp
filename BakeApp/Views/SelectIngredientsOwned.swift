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
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    //setup for custom back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var showSettings = true
    
    var geo:CGFloat
    
    //number of tiles per line
    var numPerLine:Int = 3
    //6 is good for iPhone 8, 9 is better for iPhone 11
    var numOfLines:Int {
        Int(self.geo/100) + 1
    }
  

    var ingredientNames: [String] {
        let numOfIng = self.numPerLine*self.numOfLines
        var stringArray = Array(repeating: "", count: numOfIng)
        
        for counter in 0..<numOfIng {
            let name = self.ingStatus[counter].ingredientName!
            stringArray[counter] = name
        }
        
        stringArray.sort()
        return stringArray
    }
    
    var body: some View {
        
        return GeometryReader { geometry in
            
            VStack {
                
                Text("Select any missing ingredients:")
                                  .font(.system(size:28))
                                  .foregroundColor(K.textColor)
                    .padding(.bottom)
                    .padding(.top, -10)
                              
                //body of view
                VStack {
                    ForEach(0..<Int(self.numOfLines)) { number in
                        //returns HStacks of length numPerLine
                        HStack {
                            ForEach(self.thirdNumber(number:number)..<self.fourthNumber(number:number)) { counter in
                                if counter < self.ingStatus.count {
                                    IngTile(name: self.ingredientNames[counter])
                                        .padding(5)
                                        .padding(.trailing,0)
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
                    .frame(width: 300, height: 50, alignment: .center)
                
                //continue button
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: SeeAllIng()) {
                        Text("See all ingredients")
                            .padding(.bottom)
                    }
                    
                }.padding(.bottom)
                    .padding(.horizontal)
                
            }.navigationBarItems(trailing:
                    Button("Done") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            )
        }
    }
    //functions to calculate the grid-style view of ingredient tiles
    func secondNumber() -> Int {
        let secondNumber = ((self.ingStatus.count-1)/numPerLine)+1
        return secondNumber
    }
    
    func thirdNumber(number:Int) -> Int {
        let thirdNumber = (1+numPerLine*number)-1
        return thirdNumber
    }
    
    func fourthNumber(number:Int) -> Int {
        let fourthNumber = numPerLine + numPerLine*number
        return fourthNumber
    }
}

struct SelectIngredientsOwned_Previews: PreviewProvider {
    static var previews: some View {
        SelectIngredientsOwned(geo: 667)
    }
}
