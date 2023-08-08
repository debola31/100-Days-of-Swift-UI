//
//  FlagImage.swift
//  Day21
//
//  Created by ADEBOLA AKEREDOLU on 8/7/23.
//

import SwiftUI

struct FlagImage: View {
    let image: String

    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(image: "Germany")
    }
}
