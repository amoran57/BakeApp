//
//  HelpViewPage.swift
//  BakeApp
//
//  Created by Alex Moran on 7/5/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct HelpViewPage: View {
    var image:Image
    var body: some View {
        VStack {
            
            VStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 325)
            .fixedSize(horizontal: false, vertical: true)
            .background(K.darkGray)
            .cornerRadius(20)
        }
    }
}

//struct HelpViewPage_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpViewPage(image: Image("page1"))
//    }
//}
