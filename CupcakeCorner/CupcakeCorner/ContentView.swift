//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.details.type) {
                        ForEach(Details.types.indices, id: \.self) {
                            Text(Details.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.details.quantity)", value: $order.details.quantity, in: 3 ... 20)
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.details.specialRequestEnabled.animation())

                    if order.details.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.details.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.details.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
