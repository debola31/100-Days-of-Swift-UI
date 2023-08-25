import UIKit

var greeting = "Hello, playground"

enum Predicates : String {
    case beginsWith = "BEGINSWITH"
    case like
    case lessThan = "<"
    case greaterThan = ">"
    
}

print("\(Predicates.like.rawValue)")
