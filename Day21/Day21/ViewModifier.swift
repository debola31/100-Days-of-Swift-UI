//
//  ViewModifier.swift
//  Day21
//
//  Created by ADEBOLA AKEREDOLU on 8/7/23.
//

import Foundation
import SwiftUI

struct customModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(color)
    }
}

extension View {
    func customized(color: Color) -> some View {
        modifier(customModifier(color: color))
    }
}
