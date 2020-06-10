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
    
//    var btnBack : some View { Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "arrow.left")
//                .aspectRatio(contentMode: .fit)
//                Text("Back")
//            }.foregroundColor(K.blue)
//    }.buttonStyle(PlainButtonStyle())
//        
//    }
    
    let practiceArray = ["breads", "pastries", "cakes", "cookies", "other"]
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(self.practiceArray, id: \.self) { row in
                    VStack {
                    SideList(typeOfBakedGood: String(row))
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
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: self.btnBack)
        }.padding(.bottom, 5)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}


