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
    
//    init() {
//           //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: K.textColor]
//       }
    
    //CoreData setup
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: IngredientsOwned.getAllIngStatus()) var ingStatus:FetchedResults<IngredientsOwned>
    //setup for custom back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    //custom back button
//    var btnBack : some View { Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
//    }) {
//        HStack {
//            Image(systemName: "arrow.left")
//                .aspectRatio(contentMode: .fit)
//            Text("Back")
//        }.foregroundColor(K.blue)
//    }.buttonStyle(PlainButtonStyle())
//    }

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
                }.navigationBarTitle(Text("Missing ingredients").foregroundColor(K.textColor).font(.system(size: 20)))
                
                
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
                    NavigationLink(destination: SeeAllIng()) {
                        Text("See all ingredients")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    { HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }.foregroundColor(K.blue)
                    }.buttonStyle(PlainButtonStyle())
                    
                }.padding(.bottom)
                    .padding(.horizontal)
//                    .padding(.leading, geometry.size.width - 140)
                
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                //use custom back button
//                .navigationBarBackButtonHidden(true)
//                .navigationBarItems(leading: self.btnBack)
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
