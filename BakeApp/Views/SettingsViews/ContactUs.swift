//
//  ContactUs.swift
//  BakeApp
//
//  Created by Alex Moran on 6/25/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContactUs: View {
    let db = Firestore.firestore()
    
    @State var message:String = ""
    @State var messageSubmitted:Bool = false
    @State var fieldLeftBlank:Bool = false
    
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            VStack {
            Text("Let us know how we can improve the app!")
                .padding(.horizontal)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(K.textColor)
            
                ZStack {
                    if self.fieldLeftBlank {
                        Text("Don't just leave us a blank message!")
                    }
                }
                .frame(height: 15)
            }
            .padding(.top, -50)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            ScrollView {
                MultilineTextField("Message...", text: self.$message)
                    .frame(width:350, alignment: .topLeading)
                    .padding(.horizontal, 5)
                    .cornerRadius(8)
            }.frame(width: 350, height: 180)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(K.textColor))
            
            Spacer()
                .frame(height: 10)
            
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                if self.message != "" {
                self.submitMessage(message: self.message)
                    self.message = ""
                } else {
                    self.fieldLeftBlank = true
                }
            }) {
                Text("Submit")
                    .foregroundColor(.blue)
            }
            
            Spacer()
        } .overlay(
            Group {
                if messageSubmitted {
                    ZStack {
                        Rectangle()
                            .frame(width:1000, height:1000)
                            .foregroundColor(.black)
                            .opacity(0.9)
                            .onTapGesture { self.messageSubmitted = false }
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 300)
                                .cornerRadius(20)
                                .foregroundColor(K.frameColor)
                            VStack {
                                Text("Feedback submitted! Thanks for your help improving BakeApp!")
                                    .foregroundColor(K.textColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                
                                Button(action: {
                                    self.messageSubmitted = false
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
    
    func submitMessage(message:String) {
        
        let newMessage:[String:Any] = [
            "message": message,
            "time": Date()
        ]
        
        var ref:DocumentReference? = nil
        ref = db.collection("messages").addDocument(data: newMessage) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.messageSubmitted = true
            }
            
        }
    }
    
}

struct ContactUs_Previews: PreviewProvider {
    static var previews: some View {
        ContactUs()
    }
}
