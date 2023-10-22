//
//  DetailView.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/14/23.
//

import MapKit
import SwiftUI

struct DetailView: View {
    var viewOptions = ["Image", "Location"]
    var person: Person
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    @State private var selectedOption = "Image"

    var body: some View {
        VStack {
            Picker("View", selection: $selectedOption) {
                ForEach(viewOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            Text("Name: \(person.name)")
            if selectedOption == "Image" {
                if let image = person.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            } else {
                if let location = person.location {
                    Map(coordinateRegion: $mapRegion, annotationItems: [location]) { loc in
                        MapMarker(coordinate: loc.coordinate)
                    }
                } else {
                    Text("No location found")
                }
            }
        }.task {
            if let location = person.location {
                mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
            }
        }
    }
}

#Preview {
    DetailView(person: Person.example)
}
