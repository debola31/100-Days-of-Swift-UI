//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by ADEBOLA AKEREDOLU on 10/19/23.
//

import SwiftUI

extension Angle {
    var threshold: Int {
        switch abs(degrees) {
        case 0..<60: return 0
        case 60..<120: return 1
        case 120..<180: return 2
        case 180..<240: return 3
        case 240..<300: return 0
        case 300..<360: return 1
        default: return 2
        }
    }

    var colors: [Color] {
        var colorMaps = [[Color]]()
        for _ in 1 ... 4 {
            var newColorMap = [Color]()
            for _ in 1 ... 4 {
                let newColors = Color(hue: Double.random(in: 0.1 ... 1), saturation: 1, brightness: 1)
                newColorMap.append(newColors)
            }
            colorMaps.append(newColorMap)
        }
        return colorMaps[threshold]
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var colorChoices: [Color] {
        var colors = [Color]()
        for _ in 1 ... 7 {
            colors.append(Color(hue: Double.random(in: 0.1 ... 1), saturation: 1, brightness: 1))
        }
        return colors
    }

    func calcOpacity(_ top: Double, _ y: Double) -> Double {
        let delta = y - top
        if delta <= 0 {
            return 0
        } else if delta > 200 {
            return 1
        } else {
            return delta / 200
        }
    }

    func calcWidth(_ bottom: Double, _ top: Double, _ y: Double) -> Double {
        let delta = y - top
        let total = bottom - top
        let percentDelta = delta / total
        if delta <= 0 {
            return 1
        } else if percentDelta < 0.5 {
            return 0.5
        } else if percentDelta > 1 {
            return 1
        } else {
            return percentDelta
        }
    }

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
//                        let hue = Double.random(in: 0.1 ... 1)
                        let rotation = Angle.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5
                        let colorChoice = rotation > Angle(degrees: 0) ? rotation.colors[index % 4] : .red
//                        let colorChoice = rotation.colors[index % 7]
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: geo.size.width * calcWidth(fullView.frame(in: .global).maxY, fullView.frame(in: .global).minY, geo.frame(in: .global).maxY))
//                            .background(colors[index % 7])
                            .background(colorChoice)
//                            .background(Color(hue: hue, saturation: 1, brightness: 1))
                            .opacity(calcOpacity(fullView.frame(in: .global).minY, geo.frame(in: .global).minY))
                            .frame(maxWidth: .infinity)
                            .rotation3DEffect(rotation, axis: (x: 0, y: 1, z: 0))
                            .onTapGesture {
//                                print("Bottom = \(fullView.frame(in: .global).maxY)")
//                                print("Top = \(fullView.frame(in: .global).minY)")
//                                print("y = \(geo.frame(in: .global).maxY)")
//                                print("calc = \(calcWidth(fullView.frame(in: .global).maxY, fullView.frame(in: .global).minY, geo.frame(in: .global).maxY))")
                                print("rotation : \(rotation.degrees)")
                                print("threshold = \(rotation.threshold)")
                                print("index = \(index % 4)")
                                print("colors = \(rotation.colors)")
                            }
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

/*
 Formula:
 if text location is less than 200 then opacity = 200 = 1 0 = 0

 y = 1/200 * x
 */

#Preview {
    ContentView()
}
