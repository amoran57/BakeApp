//
//  RectangleButton.swift
//  BakeApp
//
//  Created by Alex Moran on 5/29/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct RectangleButton: View {
    
    var text:String?
    
    var body: some View {
 
        ZStack {
            Rectangle()
                .frame(width: 300, height: 50)
                .cornerRadius(10)
                .foregroundColor(K.frameColor)
            
            Text(text!)
                .font(.system(size:25))
                .foregroundColor(K.textColor)
        }
    }
}

struct RectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RectangleButton()
    }
}
