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
            List {
                ForEach(self.practiceArray, id: \.self) { row in
                    SideList(typeOfBakedGood: String(row))
                }
            }
            .navigationBarTitle("Recipes")
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: self.btnBack)
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}


