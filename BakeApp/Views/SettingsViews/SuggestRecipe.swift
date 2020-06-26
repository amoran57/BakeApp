//
//  SuggestRecipe.swift
//  BakeApp
//
//  Created by Alex Moran on 6/25/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//
import UIKit
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct SuggestRecipe: View {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var emailText:String = ""
    @State var recipeText:String = ""
    @State var recipeSubmitted:Bool = false
    @State var fieldLeftBlank:Bool = false
    
    @State private var uploadImage:Bool = false
    @State private var enterText:Bool = false
    
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage? = nil
    
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
            
            if !uploadImage && !enterText {
                Button(action: {
                    self.uploadImage = true
                }) {
                    Text("I'd like to upload an image")
                        .foregroundColor(.blue)
                }.padding()
                
                Button(action: {
                    self.enterText = true
                }) {
                    Text("I'd like to enter a recipe manually")
                        .foregroundColor(.blue)
                }.padding()
            }
            
            if uploadImage || enterText {
                TextField("Email", text: self.$emailText)
                    .frame(width:340, alignment: .topLeading)
                    .padding(.horizontal, 5)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                
                Spacer()
                    .frame(height: 10)
            }
            
            if enterText {
                ScrollView {
                    MultilineTextField("Recipe", text: self.$recipeText)
                        .frame(width:350, alignment: .topLeading)
                        .padding(.horizontal, 5)
                        .cornerRadius(8)
                }.frame(width: 350, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(K.textColor))
                
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
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
            }
            
            if uploadImage {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                    
                } else {
                    Image("SplashScreenBowl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                    
                }
                HStack {
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        Text("Select \(self.image == nil ? "" : "a Different ")Image")
                            .padding()
                            .background(K.textColor)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                    
                    if self.image != nil {
                        Button(action:{
                            //upload image and email
                            if self.image != nil && self.emailText != "" {
                                self.submitImage(with: self.image!, email: self.emailText)
                                self.emailText = ""
                            } else {
                                self.fieldLeftBlank = true
                            }
                        }) {
                            Text("Submit")
                                .padding()
                                .background(K.textColor)
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                            
                        }
                    }
                }
            }
            Spacer()
        }.sheet(isPresented: self.$showImagePicker) {
            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
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
    
    func submitImage(with input:UIImage, email:String) {
        
        if let data = input.jpegData(compressionQuality: 0.6) {
            // Create a reference to the file you want to upload
            let imageRef = storageRef.child("\(email)/\(Date().description).jpg")
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = imageRef.putData(data, metadata: metadata)
            
            uploadTask.observe(.success) { _ in self.recipeSubmitted = true; self.image = nil }
        }
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
