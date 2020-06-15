//
//  Substitutions.swift
//  BakeApp
//
//  Created by Alex Moran on 6/15/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct Substitutions: View {
    let predefinedSubstitutes:[String:String] = [
        "cream of tartar":"stuff stuff stuff",
        "buttermilk":"stuff stuff",
        "unrelated ingredient":"nothing to report"
    ]
    var ingredients:[String]
    
    var relevantDict:[String:String] {
        var value:[String:String] = [:]
        for counter in 0..<ingredients.count {
            let sub = predefinedSubstitutes.filter({ $0.key == ingredients[counter]})
            if !sub.isEmpty {
                value.updateValue(sub.first?.value ?? "", forKey: sub.first?.key ?? "")
            }
        }
        return value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Missing some ingredients?")
                .font(.system(size:24))
                .bold()
            Spacer()
                .frame(height: 30)
            Text("You can let us know which ingredients you're missing, and we'll find a new recipe for you.")
                .padding()
            NavigationLink(destination: SelectIngredientsOwned()) {
                Text("Indicate missing ingredients")
                    .padding(.horizontal, 40)
            }
            Spacer()
                .frame(height: 50)
            if relevantDict.count > 0 {
                Text("Or, if you're missing one of the following ingredients, you can try making a substitution instead:")
                    .padding()
                ForEach(0..<ingredients.count) {index in
                    if self.predefinedSubstitutes[self.ingredients[index]] != nil {
                        Text(self.predefinedSubstitutes[self.ingredients[index]]!)
                            .padding(.bottom)
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

struct Substitutions_Previews: PreviewProvider {
    static var previews: some View {
        Substitutions(ingredients:recipeData[3].sysIng)
    }
}
