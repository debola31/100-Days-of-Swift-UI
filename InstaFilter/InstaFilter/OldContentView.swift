//
//  OldContentView.swift
//  InstaFilter
//
//  Created by ADEBOLA AKEREDOLU on 8/27/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct OldContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)

        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    }

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
}

struct OldContentView_Previews: PreviewProvider {
    static var previews: some View {
        OldContentView()
    }
}
