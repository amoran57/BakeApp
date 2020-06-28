//
//  ContentView.swift
//  IngTilePractice
//
//  Created by Alex Moran on 6/28/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI


struct IngTile : View {
    
    var body: some View {
        VStack {
        Text("cream of tartar")
            .frame(minWidth: 50, idealWidth: 50, maxWidth: 80, minHeight: 20, idealHeight: 20, maxHeight: 20)
            
            .padding(.horizontal, 8)
            .padding(.vertical)
            .multilineTextAlignment(.center)
            .background(Color.gray)
            .cornerRadius(10)
        
            Spacer()
                .frame(height:5)
            
        Text("blueberries")
//        .frame(height: 20)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 8)
        .padding(.vertical)
        .background(Color.gray)
        .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IngTile()
    }
}
