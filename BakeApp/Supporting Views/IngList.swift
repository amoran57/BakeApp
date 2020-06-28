//
//  IngList.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI


struct IngList: View {
    //input as Ingredients type
    var ingList: [String]
    
    var showDismiss:Bool
    @Binding var showSheet:Bool
    
    var text:String = "Ingredients"
    
    var body: some View {
        VStack {
            //heading
            HStack(alignment: .top) {
                Text(text)
                    .foregroundColor(K.textColor)
                    .font(.system(size: 32))
                    .fontWeight(.regular)
//                    .frame(width: 360, alignment: .leading)
                    .padding(.horizontal, 5)
                if self.showDismiss {
                    Button(action:{
                        self.showSheet = false
                    }) {
                        Text("Dismiss")
                            .foregroundColor(.blue)
                            .padding([.trailing, .top], 5)
                    }
                }
            }
            VStack {
            ForEach(self.ingList, id: \.self) { ing in
                Text(ing)
                    .foregroundColor(K.textColor)
                .font(.system(size: 16))
                .frame(width: 360, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.top, .leading, .bottom], 10)
                }
            }.padding(.leading, 20)
        }
        .frame(alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}


