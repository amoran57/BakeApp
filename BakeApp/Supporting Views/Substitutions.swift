//
//  Substitutions.swift
//  BakeApp
//
//  Created by Alex Moran on 6/15/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct Substitutions: View {
    
    @Binding var goToIngSelect:Bool
    @Binding var showingSheet:Bool
    @Binding var showOverlay:Bool
    var delegate:RecipeDetail
    
    var ingredients:[String]
    
    let predefinedSubstitutes:[String:String] = [
        "cream of tartar":"sdkjfskghsidsks fdjfd sdkfd skjdh",
        "buttermilk":"stuff stuff",
        "flour":"almond flour!",
        "unrelated ingredient":"nothing to report"
    ]
    
    
    var areSubs:Bool {
        var value:Bool = false
        for counter in 0..<ingredients.count {
            let sub = predefinedSubstitutes.filter({ $0.key == ingredients[counter]})
            if !sub.isEmpty {
                value = true
            }
        }
        return value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Missing some ingredients?")
                .font(.system(size:22))
                .bold()
                .padding()
            
            Spacer()
                .frame(height: 10)
            
            Text("You can let us know which ingredients you're missing, and we'll find a new recipe for you.")
                .padding(.horizontal)
            
            Button(action: {
                self.showOverlay = false
                self.showingSheet = false
                self.delegate.goToIngSelect2 = true
                self.delegate.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Go Back to Home Page")
                    .foregroundColor(.blue)
                .padding(.horizontal, 50)
                    .padding(.top)
            }
            
            
            Spacer()
                .frame(height: 10)
            
            if areSubs {
                Text("Or, if you're missing one of the following ingredients, you can try making a substitution instead:")
                    .padding()
                ForEach(0..<ingredients.count) { index in
                    if self.predefinedSubstitutes[self.ingredients[index]] != nil {
                        Group {
                        Text("For ") +
                            Text("\(self.ingredients[index]), ").fontWeight(.black) +
                        Text("use \(self.predefinedSubstitutes[self.ingredients[index]]!)")
                        }.padding(.horizontal)
                    }
                }
            }
            
            Spacer()
            
        }.frame(width: 300, height: 500)
            .background(K.frameColor)
            .cornerRadius(10)
            .foregroundColor(K.textColor)
        
    }
}
//
//struct Substitutions_Previews: PreviewProvider {
//    static var previews: some View {
//        Substitutions(goToIngSelect: .constant(false), showingSheet:.constant(false), showOverlay: .constant(false), delegate: RecipeDetail(),ingredients:recipeData[6].sysIng)
//    }
//}
