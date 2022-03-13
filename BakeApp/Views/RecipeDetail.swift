//
//  Recipe Detail.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages
import URLImage

struct RecipeDetail: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var userSettings = UserSettings()
    
    @State var showingAlert = false
//    @State var index: Int = 0
    
    @State private var showingSheet = false
    @State private var showingSheet2 = false
    @State private var showOverlay = false
    
    @State var goToIngSelect:Bool = false
    var fromHomePage = false
    
    var recipe: Recipe
    @Binding var practiceArray:[Recipe]?
    
    var showSettings = true
    var remove = false
    var restore = false
    var deleteDelegate:DeleteDelegate?
    var restoreDelegate:RestoreDelegate?
    
    @Binding var goToIngSelect2:Bool
    
    
    
    var body: some View {
        
        VStack {
            
            if userSettings.primaryViewIsTile  {
                VStack {
                    
                    RecipeTop(recipe:recipe)

                    //                }
                    HStack {
                        
                        Button("Show ingredients") {
                            self.showingSheet.toggle()
                        }.sheet(isPresented: $showingSheet) {
                            ScrollView {
                                IngList(ingList:self.recipe.ingredients, showDismiss:true, showSheet: self.$showingSheet, text: "\(self.recipe.name): Ingredients")
                                    .padding(.top)
                                Button(action:{
                                    self.showOverlay.toggle()
                                }) {
                                    Text("Missing ingredients?")
                                }.padding()
                            }
                            .overlay(
                                VStack {
                                    if self.showOverlay {
                                        ZStack {
                                            Rectangle()
                                                .frame(width:1000, height:1000)
                                                .foregroundColor(.black)
                                                .opacity(0.9)
                                                .onTapGesture { self.showOverlay = false }
                                            
                                            Substitutions(goToIngSelect: self.$goToIngSelect,
                                                          showingSheet: self.$showingSheet,
                                                          showOverlay: self.$showOverlay,
                                                          delegate: self,
                                                          fromHomePage: self.fromHomePage,
                                                          ingredients: self.recipe.sysIng)
                                            
                                        }.frame(width: 1000, height: 1000)
                                    } else {
                                        EmptyView()
                                    }
                                }
                            )
                            
                        }.padding(.bottom)
                        
                        
                        
                        Spacer()
                            .frame(width: 75)
                        
                        Button("Show instructions") {
                            self.showingSheet2.toggle()
                        }.sheet(isPresented: $showingSheet2) {
                            ScrollView {
                                InsList(insList: self.recipe.instructions, showDismiss: true, showSheet: self.$showingSheet2, text: "\(self.recipe.name): Instructions")
                                    .padding(.top)
                            }
                        }.padding(.bottom)
                    }.padding(.bottom)
                        .foregroundColor(.blue)
                }
                
            } else {
                ScrollView {
                  
                    RecipeScroll(recipe:recipe)
                    
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
                
            }
        }.background(
            Group {
                if recipe.imageURL != nil {
                    URLImage(URL(string: recipe.imageURL!)!)
                    { proxy in
                        proxy.image
                            .resizable()
                            .opacity(self.colorScheme == .dark ? 0.2 : 0.5)
                            .edgesIgnoringSafeArea(.all)
                            .aspectRatio(contentMode: .fill)
                    }
                    
                    
                    
                } else {
                    recipe.image.resizable()
                        .opacity(self.colorScheme == .dark ? 0.2 : 0.5)
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                }
            }
            
        )
            .navigationBarTitle("", displayMode: userSettings.primaryViewIsTile ? .automatic : .inline)
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
                            
                            Alert(title: Text("Are you sure you want to remove this recipe?"), primaryButton: .destructive(Text("Remove")) {
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
        
        
    
    }
}




//struct RecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetail(recipe: recipeData[0], practiceArray: .constant(nil), goToIngSelect2: true)
//    }
//}
