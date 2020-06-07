//
//  SwiftUIView.swift
//  BakeApp
//
//  Created by Alex Moran on 6/6/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI
import Pages


struct CarsView: View {
    let cars = Array(repeating: 0, count: recipeData[1].instructions.count)
    @State var index: Int = 0
    
    var body: some View {
        ModelPages(cars, currentPage: $index) { pageIndex, car in
            StepByStep(index: pageIndex, recipe: recipeData[1])
        }
    }
}

struct PlayWithPages_Previews: PreviewProvider {
    static var previews: some View {
        CarsView()
    }
}
