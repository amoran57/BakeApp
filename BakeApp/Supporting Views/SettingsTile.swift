//
//  SettingsTile.swift
//  BakeApp
//
//  Created by Alex Moran on 6/7/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct SettingsTile: View {
    
    var text:String
   
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: 150, height: 250)
            .cornerRadius(20)
                .foregroundColor(K.frameColor)
            VStack{
            Text(text)
                .foregroundColor(K.textColor)
                .multilineTextAlignment(.center)
            
            }
        }.frame(width: 150, height: 250)
    }
}

struct SettingsTile_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTile(text: "Here it is sdgsdgs gssghsgh")
    }
}
