//
//  BackgroundView.swift
//  BakeApp
//
//  Created by Alex Moran on 6/27/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import URLImage

struct BackgroundView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var activeImageIndex = Int.random(in: 0...recipeData.count-1)
    let imageSwitchTimer = Timer.publish(every: 3, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        Group {
            if recipeData[self.activeImageIndex].imageURL != nil {
                URLImage(URL(string: recipeData[self.activeImageIndex].imageURL!)!)
                { proxy in
                    proxy.image
                        .resizable()
                        .opacity(self.colorScheme == .dark ? 0.2 : 0.5)
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                }
                
            } else {
                recipeData[self.activeImageIndex].image
                    .resizable()
                    .opacity(colorScheme == .dark ? 0.2 : 0.5)
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
            }
        }.onReceive(self.imageSwitchTimer) { _ in
            var nextIndex = Int.random(in: 0...recipeData.count-1)
            while nextIndex == self.activeImageIndex {
                nextIndex = Int.random(in: 0...recipeData.count-1)
            }
            self.activeImageIndex = nextIndex
        }
    }

}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
