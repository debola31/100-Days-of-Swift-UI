//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.details.name)
                TextField("Street Address", text: $order.details.streetAddress)
                TextField("City", text: $order.details.city)
                TextField("Zip", text: $order.details.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
//            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
