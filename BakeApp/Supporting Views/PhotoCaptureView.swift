//
//  PhotoCaptureView.swift
//  CapturingPhotoSwiftUI
//
//  Created by Mohammad Azam on 8/9/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import SwiftUI
import UIKit

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}

#if DEBUG
struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), image: .constant(UIImage(imageLiteralResourceName: "")))
    }
}
#endif
