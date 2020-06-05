//
//  PracticeIngList.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

//This is the ingredient selection page, where users can indicate whether they are missing certain ingredients

struct SelectIngredientsOwned: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let recipeScreener = RecipeScreener()
    var numPerLine:Int? = 3
    var setData:Bool
    
    
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "arrow.left")
                .aspectRatio(contentMode: .fit)
            Text("Back")
        }.foregroundColor(K.blue)
    }.buttonStyle(PlainButtonStyle())
        
    }
    
    var body: some View {
        
        setCoreData()
        
        return GeometryReader { geometry in
            
            VStack {
                //text heading
                Text("What are you missing?")
                    .foregroundColor(K.textColor)
                    .font(.system(size:24))
                    .bold()
                    .padding(.leading)
                    .padding(.top, -50)
                
                //body of view
                ScrollView {
                VStack {
                    ForEach(0..<self.secondNumber()) { number in
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
                        .padding(.leading)
                    }
                }
                }
                
                
                ZStack {
                    if filterByTime.couldNotFilter {
                        Text("No recipes matched either your time limits or ingredient specifications.")
                    } else if filterByTime.couldNotFilterByIng {
                        Text("We were able to find a recipe within your time limits, but were unable to filter by your ingredient specifications.")
                    } else if filterByTime.couldNotFilterByTime {
                        Text("We were able to find a recipe with your ingredient specifications, but were unable to filter by your requested time limits.")
                    }
                }.font(.system(size:12))
                    .foregroundColor(K.textColor)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 100, alignment: .center)
                
                //continue button
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    { HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }.foregroundColor(K.blue)
                    }.buttonStyle(PlainButtonStyle())
                    
                }.padding(.bottom)
                    .padding(.leading, geometry.size.width - 140)
                
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .fixedSize(horizontal: false, vertical: true)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: self.btnBack)
        }
    }
    
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
//
//struct PracticeIngList_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectIngredientsOwned()
//    }
//}
