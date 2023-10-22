import UIKit

var greeting = "Hello, playground"

var chest = [Int]()
for i in 1 ... 7 {
    chest.append(i)
}

print(chest)
print([Int](repeating: Int.random(in: 1..6), count: 5))
