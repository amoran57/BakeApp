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
    
    @State var activeImageIndex = Int.random(in: 0...recipeData.count-1)
    let imageSwitchTimer = Timer.publish(every: 3, on: .main, in: .common)
        .autoconnect()

    @Binding var isTriggered:Bool
    
    var body: some View {
        Group {
            if recipeData[self.activeImageIndex].imageURL != nil {
                URLImage(URL(string: recipeData[self.activeImageIndex].imageURL!)!)
                { proxy in
                    proxy.image
                        .resizable()
                        .opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                }
                
            } else {
                recipeData[self.activeImageIndex].image.resizable()
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
            }
        }.onReceive(self.imageSwitchTimer) { _ in
            print("Received signal from timer")
            var nextIndex = Int.random(in: 0...recipeData.count-1)
            while nextIndex == self.activeImageIndex {
                print("Duplicate index; trying again")
                nextIndex = Int.random(in: 0...recipeData.count-1)
            }
            self.activeImageIndex = nextIndex
        }
    }

}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(isTriggered: .constant(true))
    }
}
