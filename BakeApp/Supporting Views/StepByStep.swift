//
//  StepByStep.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct StepByStep: View {
    @State private var rect1: CGRect = CGRect()
    var index:Int
    var recipe:Recipe

    var body: some View {

        VStack {

            Spacer()
                .frame(height: 140)
            VStack {

                Text("Step \(self.index+1):")
                    .foregroundColor(K.textColor)
                    .bold()
                    .font(.system(size:24))
                    .padding(.top)

                HStack {
                    if self.recipe.ingxins![self.index].count > 0 {
                        VStack {
                            ForEach(0..<self.recipe.ingxins![self.index].count) { ing in

                                Text("\(self.recipe.ingredients[self.recipe.ingxins![self.index][ing]])")
                                    .foregroundColor(K.textColor)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                if ing != self.recipe.ingxins![self.index].count-1 {
                                    Divider()
                                        .background(K.textColor)
                                }
                            }
                        }.padding(.leading)


                        Divider()
                            .background(K.textColor)

                    }
                    if self.recipe.ingxins![self.index].count > 0 {
                        Text(self.recipe.instructions[self.index])
                            .foregroundColor(K.textColor)
                            .padding(.horizontal, 5)
                            .frame(minWidth: 180)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(self.recipe.instructions[self.index])
                            .foregroundColor(K.textColor)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(.bottom)

            }
            .frame(width: 325)
            .fixedSize(horizontal: false, vertical: true)
            .background(K.frameColor)
            .cornerRadius(20)

            Spacer()

        }
        .frame(width: 375, height: 700)
//        .fixedSize(horizontal:false, vertical:true)
//    .overlay(Color.clear.modifier(GeometryGetterMod(rect: $rect1)))

    }

}

struct GeometryGetterMod: ViewModifier {

    @Binding var rect: CGRect

    func body(content: Content) -> some View {
        print(content)
        return GeometryReader { (g) -> Color in // (g) -> Content in - is what it could be, but it doesn't work
            DispatchQueue.main.async { // to avoid warning
                self.rect = g.frame(in: .global)
            }
            print(g.size.height)
            return Color.clear // return content - doesn't work
        }
    }
}


//struct StepByStep_Previews: PreviewProvider {
//    static var previews: some View {
//        StepByStep(index:0, recipe: recipeData[0])
//    }
//}
