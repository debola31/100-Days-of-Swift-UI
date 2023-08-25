//
//  DetailView.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/23/23.
//

import SwiftUI

struct DetailView: View {
    var user: CachedUser

    var body: some View {
        Form {
            Section("User Info") {
                HStack {
                    Text("Name :")
                    Text(user.wrappedName)
                }
                HStack(spacing: 5) {
                    Text("Age :")
                    Text(user.age, format: .number)
                }
            }

            Section("Friends") {
                ForEach(user.wrappedFriends) {
                    Text($0.wrappedName)
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User.exampleUser!)
//    }
//}
