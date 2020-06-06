//
//  StepByStep.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct StepByStep: View {
    
    var index:Int
    var ingredients:[String] = ["Ing 1", "Ing 2", "Ing 3"]
    var instructions:[String]
    var reference:[[Int]] = [
    [1],
    [0,1],
    []
    ]
    
    var body: some View {
      
        VStack {
            
            VStack {
                
            Text("Step \(index+1):")
                .foregroundColor(K.textColor)
                .bold()
                .font(.title)
                .padding(.top)
                
            HStack {
                VStack {
                    ForEach(0..<self.ingredients.count) { index in
                        Text(self.ingredients[index])
                            .foregroundColor(K.textColor)
                    }
                }.padding(.horizontal)
                
                
                Divider()
                    .shadow(color: K.textColor, radius: 2, x: 1, y: 0)
                
                Text(self.instructions[self.index])
                    .foregroundColor(K.textColor)
                    .padding(.trailing)
                    .fixedSize(horizontal: false, vertical: true)
                }.padding(.bottom)
                
            }
            .frame(width: 325)
            .fixedSize(horizontal: false, vertical: true)
            .background(K.frameColor)
            .cornerRadius(20)
             
            
            
            Spacer()
                .frame(height: 100)
            
            
            
//            HStack {
//                ForEach(0..<self.instructions.count) { index in
//                    Circle()
//                        .frame(width: index == self.index ? 10 : 8,
//                               height: index == self.index ? 10 : 8)
//                        .foregroundColor(index == self.index ? Color.blue : .white)
//                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
//                        .padding(.bottom, 8)
//                        .animation(.spring())
//                }
//            }
        }
        .frame(width: 375)
        
            
//            HStack {
//                if index != 0 {
//                    NavigationLink(destination: StepByStep(index: self.index-1)) {
//                        HStack {
//                            Image(systemName: "arrow.left")
//                            Text("Previous step")
//                        }.foregroundColor(K.blue)
//                    }
//                }
//
//                Spacer()
//
//                if index < instructions.count-1 {
//                    NavigationLink(destination: StepByStep(index: self.index+1)) {
//                        HStack {
//                            Text("Next step")
//                            Image(systemName: "arrow.right")
//                        }.foregroundColor(K.blue)
//                    }
//                } else if index == instructions.count-1 {
//                    NavigationLink(destination: RecipeDetail(recipe: recipeData[2])) {
//                        HStack {
//                            Text("Done!")
//                        }.foregroundColor(K.blue)
//                    }
//                }
//            }.padding(.horizontal)
        
    }
}

struct StepByStep_Previews: PreviewProvider {
    static var previews: some View {
        StepByStep(index:0, instructions: recipeData[0].instructions)
    }
}
