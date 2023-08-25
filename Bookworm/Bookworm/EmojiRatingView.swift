//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            Text("🥇")
        case 2:
            Text("🥈")
        case 3:
            Text("🥉")
        case 4:
            Text("4️⃣")
        default:
            Text("5️⃣")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
