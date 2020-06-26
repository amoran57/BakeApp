//
//  SuggestRecipe.swift
//  BakeApp
//
//  Created by Alex Moran on 6/25/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct SuggestRecipe: View {
    let db = Firestore.firestore()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var emailText:String = ""
    @State var recipeText:String = ""
    @State var recipeSubmitted:Bool = false
    @State var fieldLeftBlank:Bool = false
    
    var body: some View {
        VStack {
            VStack{
                Text("Give us your email and your recipe, and we'll be in touch about adding it to the app!")
                    .padding(.horizontal)
                    .padding(.top, -30)
                    .font(.system(size: 20))
                    .foregroundColor(K.textColor)
                
                ZStack {
                    if fieldLeftBlank {
                        Text("Make sure you enter both your email address and a recipe.")
                            .foregroundColor(K.textColor)
                            .font(.system(size:12))
                    }
                }.frame(height:10)
                    .padding(.top, 5)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            TextField("Email", text: self.$emailText)
                .frame(width:340, alignment: .topLeading)
                .padding(.horizontal, 5)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            
            Spacer()
                .frame(height: 10)
            
            ScrollView {
                MultilineTextField("Recipe", text: self.$recipeText)
                    .frame(width:350, alignment: .topLeading)
                    .padding(.horizontal, 5)
                    .cornerRadius(8)
            }.frame(width: 350, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(K.textColor))
            
            
            VStack {
                Button(action: {
                    if self.emailText == "" || self.recipeText == "" {
                        self.fieldLeftBlank = true
                    } else {
                        self.submitRecipe(email:self.emailText,recipe:self.recipeText)
                        self.emailText = ""
                        self.recipeText = ""
                    }
                }) {
                    Text("Submit")
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Spacer()
            }
            
        }
        .overlay(
            Group {
                if recipeSubmitted {
                    ZStack {
                        Rectangle()
                            .frame(width:1000, height:1000)
                            .foregroundColor(.black)
                            .opacity(0.9)
                            .onTapGesture { self.recipeSubmitted = false }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 300)
                                .cornerRadius(20)
                                .foregroundColor(K.frameColor)
                            VStack {
                                Text("Recipe submitted! Thanks for your help improving BakeApp!")
                                    .foregroundColor(K.textColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                
                                Button(action: {
                                    self.recipeSubmitted = false
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("Go back")
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }.frame(width: 300, height: 300)
                        }
                    }.frame(width: 1000, height: 1000)
                } else {
                    EmptyView()
                }
            }
        )
        
    }
    
    
    
    
    func submitRecipe(email:String?,recipe:String?) {
        
        guard let email = email else {return}
        guard let recipe = recipe else {return}
        
        let newRecipe:[String:Any] = [
            "email": email,
            "recipe": recipe,
            "time": Date()
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("suggestedRecipes").addDocument(data: newRecipe) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.recipeSubmitted = true
            }
        }
    }
    
}

struct SuggestRecipe_Previews: PreviewProvider {
    static var previews: some View {
        SuggestRecipe()
    }
}
