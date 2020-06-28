//
//  ContentView.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct RecipeList: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var filteredArray = recipeData
        .enumerated()
        .filter { !(SetUpIng.userSettings.removedRecipeIndex.contains($0.offset)) }
        .map { $0.element }
    
    let practiceArray = ["breads", "pastries", "cakes", "cookies", "other"]
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(self.practiceArray, id: \.self) { row in
                    VStack {
                        SideList(typeOfBakedGood: String(row), filteredArray: self.filteredArray)
                        if row != "other" {
                            Divider()
                        }
                    }.padding(.leading)
                }.padding(.bottom)
            }
            .navigationBarTitle("Recipes")
            .navigationBarItems(trailing: NavigationLink(destination: Settings()) {
                Text("Settings")
            })
        }.padding(.bottom, 5)
            .onAppear(perform: {
                self.filteredArray = recipeData
                    .enumerated()
                    .filter { !(defaults.object(forKey: K.Defaults.removedRecipeIndex) as! Array).contains($0.offset) }
                    .map { $0.element }
                
            })
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}


