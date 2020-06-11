//
//  Recipe Detail.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages

struct RecipeDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var userSettings = UserSettings()
    @State var showingAlert = false
    @State var index: Int = 0
    @State private var showingSheet = false
    @State private var showingSheet2 = false
    var recipe: Recipe
    @Binding var practiceArray:[Recipe]?
    var showSettings = true
    var remove = false
    var restore = false
    var deleteDelegate:DeleteDelegate?
    var restoreDelegate:RestoreDelegate?
    
    var body: some View {
        
        VStack {
            if userSettings.primaryViewIsTile  {
                //                ScrollView {
                //tease preview
                //                    CircleImage(image: recipe.image)
                
                //                    name of recipe
                Text(recipe.name)
                    .foregroundColor(K.textColor)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .frame(width: 350)
                    .lineLimit(1)
                
                //total time
                Text("Total time: \(recipe.totTimeText)")
                    .foregroundColor(K.textColor)
                    .font(.system(size: 20))
                
                //prep and bake times
                HStack {
                    Text("Prep time: \(recipe.prepTimeText)")
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.trailing)
                    Text("|")
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.center)
                    Text("Bake time: \(recipe.bakeTimeText)")
                        .foregroundColor(K.textColor)
                        .multilineTextAlignment(.leading)
                }.font(.system(size: 12))
                    .frame(width: 400)
                    .fixedSize(horizontal: true, vertical: true)
                
                Spacer()
                    .frame(height: 20.0)
                
                ModelPages(recipe.instructions, currentPage: $index,
                           currentTintColor: K.UITextColor, tintColor: K.UIFrameColor)
                { index, _  in
                    StepByStep(index: index, recipe: self.recipe)
                }.frame(minHeight: 500, maxHeight: .infinity)
                    .padding(.top, -50)
                //                }
                HStack {
                    
                    Button("Show ingredients") {
                        self.showingSheet.toggle()
                    }.sheet(isPresented: $showingSheet) {
                        ScrollView {
                            IngList(ingList:self.recipe.ingredients, text: "\(self.recipe.name): Ingredients")
                                .padding(.top)
                        }
                    }.padding(.bottom)
                    
                    
                    
                    
                    Spacer()
                        .frame(width: 75)
                    
                    Button("Show instructions") {
                        self.showingSheet2.toggle()
                    }.sheet(isPresented: $showingSheet2) {
                        ScrollView {
                            InsList(insList: self.recipe.instructions, text: "\(self.recipe.name): Instructions")
                                .padding(.top)
                        }
                    }.padding(.bottom)
                }.padding(.bottom)
                
            } else {
                ScrollView {
                    //tease preview
                    //                    CircleImage(image: recipe.image)
                    
                    //                    name of recipe
                    Text(recipe.name)
                        .foregroundColor(K.textColor)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                    
                    //total time
                    Text("Total time: \(recipe.totTimeText)")
                        .foregroundColor(K.textColor)
                        .font(.system(size: 20))
                    
                    //prep and bake times
                    HStack {
                        Text("Prep time: \(recipe.prepTimeText)")
                            .foregroundColor(K.textColor)
                            .multilineTextAlignment(.trailing)
                        Text("|")
                            .foregroundColor(K.textColor)
                            .multilineTextAlignment(.center)
                        Text("Bake time: \(recipe.bakeTimeText)")
                            .foregroundColor(K.textColor)
                            .multilineTextAlignment(.leading)
                    }.font(.system(size: 12))
                        .frame(width: 400)
                        .fixedSize(horizontal: true, vertical: true)
                    
                    Spacer()
                        .frame(height: 20.0)
                    
                    //ingredients
                    IngList(ingList: self.recipe.ingredients)
                    
                    Spacer()
                        .frame(height: 20.0)
                    
                    //instructions
                    InsList(insList: self.recipe.instructions)
                }
                VStack {
                    Rectangle()
                        .frame(height:0.5)
                        .foregroundColor(K.textColor)
                    Button(action: {
                        self.showingSheet.toggle()
                    }) {
                        Text("Show step-by-step detail")
                    }
                    .sheet(isPresented: $showingSheet) {
                        ScrollInsPopup(recipe: self.recipe)
                    }.padding([.bottom, .trailing])
                }.frame(width: 375, alignment: .trailing)
                
                
            }
        }.background(recipe.image.resizable()
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
            .aspectRatio(contentMode: .fill))
            .navigationBarItems(trailing:
                
                Group {
                    
                    if remove {
                        Button(action: {
                            
                            self.showingAlert = true
                        })
                        {
                            Text("Remove recipe")
                                .foregroundColor(.red)
                        }.alert(isPresented: $showingAlert) { () -> Alert in
                            
                            Alert(title: Text("Are you sure you want to delete this recipe?"), primaryButton: .destructive(Text("Delete")) {
                                if self.practiceArray != nil {
                                    print("practiceArray exists")
                                    if let delegate = self.deleteDelegate {
                                        print("delegate exists")
                                        delegate.externalDelete(recipe:self.recipe.name)
                                        print("recipe deleted")
                                    }
                                }
                                
                                print("exiting view")
                                self.presentationMode.wrappedValue.dismiss()
                                print("exited view")
                                }, secondaryButton: .cancel())
                        }
                    } else if restore {
                        Button(action: {
                            self.showingAlert = true
                        })
                        {
                            Text("Restore recipe")
                                .foregroundColor(.green)
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text("Are you sure you want to restore this recipe?"), primaryButton: .default(Text("Restore")) {
                                if self.practiceArray != nil {
                                    print("practiceArray exists")
                                    if let delegate = self.restoreDelegate {
                                        print("delegate exists")
                                        delegate.restoreRecipe(recipe:self.recipe.name)
                                        print("recipe restored")
                                    }
                                }
                                
                                print("exiting view")
                                self.presentationMode.wrappedValue.dismiss()
                                print("exited view")
                                
                                }, secondaryButton: .cancel())
                        }
                    }
                    else if showSettings {
                        NavigationLink(destination: Settings()) {
                            Text("Settings")
                        }
                    }
            })
            
            .navigationBarTitle("\(userSettings.primaryViewIsTile ? "" : recipe.name)", displayMode: .inline)
        
    }
    
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: recipeData[0], practiceArray: .constant(nil))
    }
}
