//
//  HomeBackground.swift
//  BakeApp
//
//  Created by Alex Moran on 6/11/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

struct HomeBackground: View {
    @State var activeImageIndex = Int.random(in: 0...recipeData.count-1)
    var imageSwitchTimer:Timer.TimerPublisher
    @State var timerIndex:Int = 0
    var body: some View {
        Group {
        recipeData[self.activeImageIndex].image
            .resizable()
            .opacity(0.2)
            .edgesIgnoringSafeArea(.all)
            .aspectRatio(contentMode: .fill)
            .onReceive(self.imageSwitchTimer) { _ in
                
                self.timerIndex += 1
                print(self.timerIndex)
                //            var nextIndex = Int.random(in: 0...recipeData.count-1)
                //            while nextIndex == self.activeImageIndex {
                //                print("Duplicate index; trying again")
                //                nextIndex = Int.random(in: 0...recipeData.count-1)
                //            }
                //            self.activeImageIndex = nextIndex
            }
        }
    }
}

//struct HomeBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeBackground()
//    }
//}
