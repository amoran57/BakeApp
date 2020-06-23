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
    
    var fromHomePage:Bool
    
    var ingredients:[String]
    
    let predefinedSubstitutes:[String:String] = [
        "baking powder":"one part baking soda, one part cornstarch, and two parts cream of tartar.",
        "baking soda":"baking powder, 3x as much as called for. Note that this will taste salty, so consider using less salt than you would otherwise.",
        "brown sugar":"sixteen parts white sugar to one part molasses (or maple syrup). The ratio is that of 1 cup : 1 tablespoon.",
        "butter":"coconut oil, although this substitution may slightly affect the flavor.",
        "cocoa powder":"hot chocolate mix--note that you may want to reduce the amount of sugar you use, to compensate.",
        "cream of tartar":"lemon juice.",
        "egg":"one-quarter cup applesauce for every egg.",
        "honey":"agave nectar, coconut nectar, maple syrup, or molasses.",
        "milk":"half and half, or cream and water in a 3:2 ratio.",
        "sour cream":"greek yogurt, cottage cheese, or buttermilk.",
        "vegatable oil":"coconut oil, canola oil, or butter.",
        "vinegar":"lemon juice"
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
        ScrollView {
            if fromHomePage {
                VStack(alignment: .leading) {
                    
                    Text("Missing some ingredients?")
                        .font(.system(size:22))
                        .bold()
                        .padding()
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("You can let us know which ingredients you're missing, and we'll find a new recipe for you:")
                        .padding(.horizontal)
                    
                    Button(action: {
                        self.showOverlay = false
                        self.showingSheet = false
                        self.delegate.goToIngSelect2 = true
                        self.delegate.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Indicate missing ingredients")
                            .foregroundColor(.blue)
                            .padding(.horizontal, 40)
                            .padding(.top)
                    }
                    
                    
                    Spacer()
                        .frame(height: 10)
                    
                    if areSubs {
                        Text("Or, if you're missing one of the following ingredients, you can try making a substitution instead:")
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(3)
                            .padding()
                        ForEach(0..<ingredients.count) { index in
                            if self.predefinedSubstitutes[self.ingredients[index]] != nil {
                                Group {
                                    Text("For ") +
                                        Text("\(self.ingredients[index]), ").fontWeight(.black) +
                                        Text("use \(self.predefinedSubstitutes[self.ingredients[index]]!)")
                                }.padding(.horizontal)
                            }
                        }.padding(.bottom)
                    }
                    
                    Spacer()
                }
            } else {
                if areSubs {
                    VStack(alignment: .leading) {
                    
                    Text("Missing some ingredients?")
                        .font(.system(size:22))
                        .bold()
                        .padding()
                    
                    Spacer()
                        .frame(height: 10)
                        
                    Text("If you're missing one of the following ingredients, you can try making a substitution:")
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        .padding()
                    ForEach(0..<ingredients.count) { index in
                        if self.predefinedSubstitutes[self.ingredients[index]] != nil {
                            Group {
                                Text("For ") +
                                    Text("\(self.ingredients[index]), ").fontWeight(.black) +
                                    Text("use \(self.predefinedSubstitutes[self.ingredients[index]]!)")
                            }.padding(.horizontal)
                        }
                    }.padding(.bottom)
                }
                } else {
                    Text("None of the ingredients in this recipe have substitutes.")
                }
            }
        }.frame(width: 300, height: 500)
            .background(K.frameColor)
            .cornerRadius(10)
            .foregroundColor(K.textColor)
        
    }
}

struct Substitutions_Previews: PreviewProvider {
    static var previews: some View {
        Substitutions(goToIngSelect: .constant(false), showingSheet:.constant(false), showOverlay: .constant(false), delegate: RecipeDetail(recipe: recipeData[6], practiceArray: .constant(nil), goToIngSelect2: .constant(false)), fromHomePage:false, ingredients:recipeData[1].sysIng)
    }
}
