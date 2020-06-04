//
//  InsList.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI


struct InsList: View {
    //input as array of Instructions
    var insList: [String]

    var body: some View {
        VStack {
            //heading
            Text("Instructions")
                .foregroundColor(K.textColor)
                .font(.system(size: 32))
                .fontWeight(.regular)
                .frame(width: 360, alignment: .leading)
                .padding(.leading, 10)
            
            Spacer()
            
            
            //list of ingredients
            VStack {
                ForEach(0..<self.insList.count) { index in
                    HStack(alignment: .top) {
                        Text("Step \(index+1):")
                            .foregroundColor(K.textColor)
                            .italic()
                            .font(.system(size: 20))
                            .frame(width: 80, alignment: .center)
                        
                        Text(self.insList[index])
                            .foregroundColor(K.textColor)
                            .font(.system(size: 16))
                            .frame(width: 280, alignment: .leading)
                    }.fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

struct InsList_Previews: PreviewProvider {
    static var previews: some View {
        InsList(insList: recipeData[5].instructions)
    }
}
