//
//  HelpView.swift
//  BakeApp
//
//  Created by Alex Moran on 6/28/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages

struct HelpView: View {
    let pages:[Image] = [
    Image("page1"),
    Image("page2")
    ]
       @State var index: Int = 0
    var body: some View {
        return GeometryReader { geometry in
            ModelPages(self.pages, currentPage: self.$index) { num, _  in
            HelpViewPage(image: self.pages[num])
          }.padding(.top, -90)
            .frame(width: geometry.size.width, height: geometry.size.height)
            
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
