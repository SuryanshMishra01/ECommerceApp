//
//  AddAdressView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 17/03/26.
//

import SwiftUI



struct AddressView: View {

    @EnvironmentObject var addVM: AddressViewModel
    @Environment(\.dismiss) var dismiss
    
    // Form fields
    @State private var state = ""
    @State private var street = ""
    @State private var city = ""
    @State private var pincode = ""
    @State private var phone = ""

    var body: some View {

        VStack {

            // Address List
            List(addVM.addressList) { address in

                HStack {

                    VStack(alignment: .leading) {
                        Text(address.phone)
                            .font(.headline)

                        Text(address.street)
                        Text("\(address.city) - \(address.pincode)")
                            .font(.caption)
                        Text(address.state)
                    }

                    Spacer()

                    if addVM.defaultAddress?.id == address.id {
                        Text("Default")
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    addVM.setDefault(address)
                }
            }
            .frame(height: 200)

            Divider()

            // Add Address Form
            Form {

                TextField("Street", text: $street)
                TextField("City", text: $city)
                TextField("State", text: $state)
                TextField("Pincode", text: $pincode)
                TextField("Contact No.", text: $phone)

                Button("Add Address") {

                    let newAddress = AddressModel(
                        street: street,
                        city: city,
                        state: state,
                        pincode: pincode,
                        phone: phone
                    )

                    addVM.saveAddress(newAddress)

                    // Reset form
                    state = ""
                    street = ""
                    city = ""
                    pincode = ""
                    phone = ""
                }
            }
            .frame(maxWidth: 400)
            Button("Close"){
                dismiss()
            }

        }
        
        .padding()
        .onAppear {
            addVM.loadAllAddress()
        }
    }
}
