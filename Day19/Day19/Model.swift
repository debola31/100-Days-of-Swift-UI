//
//  Model.swift
//  Day19
//
//  Created by ADEBOLA AKEREDOLU on 8/6/23.
//

import Foundation
import SwiftUI

extension UnitDuration {
    static let days = UnitDuration(symbol: "days",
                                converter: UnitConverterLinear(coefficient: 86400.0))
}
