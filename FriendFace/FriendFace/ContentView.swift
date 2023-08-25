//
//  ContentView.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/23/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var downloading = false
    @State private var failedDownload = false
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>

    func deleteUsers(at offsets: IndexSet) {
        for offset in offsets {
            let user = users[offset]
            moc.delete(user)
        }

        try? moc.save()
    }

    func downloadData() async -> [User] {
        downloading = true
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            downloading = false
            return decodedUsers

        } catch {
            print(error)
            downloading = false
            failedDownload = true
            return []
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Users") {
                    ForEach(users) { user in
                        NavigationLink {
                            DetailView(user: user)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(user.wrappedName)
                                    Text(user.isActive ? "Online" : "Offline")
                                        .foregroundColor(user.isActive ? .green : .gray)
                                        .font(.footnote)
                                }
                            }
                        }
                    }.onDelete(perform: deleteUsers)
                }
            }
            .navigationTitle("FriendFace")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .task {
//            if users.isEmpty {
            let downloadedUsers = await downloadData()
            await MainActor.run {
                for user in downloadedUsers { // Save to CoreData
                    let newUser = CachedUser(context: moc)
                    newUser.name = user.name
                    newUser.id = user.id
                    newUser.about = user.about
                    newUser.address = user.address
                    newUser.age = user.age
                    newUser.email = user.email
                    newUser.isActive = user.isActive
                    newUser.registered = user.registered
                    newUser.tags = user.tags.joined(separator: ",")

                    let friends: [CachedFriend] = user.friends.map {
                        let friend = CachedFriend(context: moc)
                        friend.name = $0.name
                        friend.id = $0.id
                        return friend
                    }
                    newUser.friends = NSSet(array: friends)
                    try? moc.save()
                }
            }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
