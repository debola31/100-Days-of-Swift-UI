//
//  PersonClip.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/14/23.
//

import SwiftUI

struct PersonClip: View {
    var person: Person
    var new = false
    var image: Image? {
        if let personImage = person.image {
            return Image(uiImage: personImage)
        } else { return nil }
    }

    var body: some View {
        HStack {
            image?
                .resizable()
                .frame(maxWidth: 50, maxHeight: 50)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            Text(person.name)
                .padding(.horizontal)
        }
    }
}

#Preview {
    PersonClip(person: Person.example)
}
