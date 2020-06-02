//
//  CircleImage.swift
//  BakeApp  1
//
//  Created by Alex Moran on 5/14/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//


import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
        .resizable()
            .frame(width: 230, height: 230)
            .clipShape(Circle())
        .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: recipeData[0].image)
    }
}
