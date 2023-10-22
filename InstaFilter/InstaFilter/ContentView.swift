//
//  ContentView.swift
//  InstaFilter
//
//  Created by ADEBOLA AKEREDOLU on 8/25/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = .sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?

    var containsFilterKey: [Bool] {
        guard let _ = inputImage else { return [false, false, false] }
        let inputKeys = currentFilter.inputKeys

        let containsIntensity = inputKeys.contains(kCIInputIntensityKey)
        let containsRadius = inputKeys.contains(kCIInputRadiusKey)
        let containsScale = inputKeys.contains(kCIInputScaleKey)

        return [containsIntensity, containsRadius, containsScale]
    }

    let context = CIContext()

    func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                VStack {
                    if containsFilterKey[0] {
                        HStack {
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity) { _ in
                                    applyProcessing()
                                }
                        }
                    }

                    if containsFilterKey[1] {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius)
                                .onChange(of: filterRadius) { _ in
                                    applyProcessing()
                                }
                        }
                    }

                    if containsFilterKey[2] {
                        HStack {
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale) { _ in
                                    applyProcessing()
                                }
                        }
                    }
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter: \(currentFilter.name)") {
                        showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save", action: save).disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
                Button("Depth Of Field") { setFilter(CIFilter.depthOfField()) }
                Button("Gamma Adjust") { setFilter(CIFilter.gammaAdjust()) }

                Button("Cancel", role: .cancel) {}
            }
            .onChange(of: inputImage) { _ in loadImage() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
