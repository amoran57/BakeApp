//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport



struct IngTile : View {
    
    var body: some View {
        ZStack {
        Text("flour")
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
            .padding(.vertical)
            .background(Color.gray)
            .cornerRadius(10)
        }.frame(height: 25)
    }
}

PlaygroundPage.current.setLiveView(IngTile())
