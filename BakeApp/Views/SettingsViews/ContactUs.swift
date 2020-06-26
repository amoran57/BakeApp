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
    
    var body: some View {
        VStack {
            Text("Let us know how we can improve the app!")
            Spacer()
            TextField("Type here...", text: self.$message)
            Spacer()
            Button(action: {
                self.submitMessage(message: self.message)
            }) {
                Text("Submit")
            }
            
            if self.messageSubmitted {
                Text("Thanks for the feedback!")
            }
            
        }
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
