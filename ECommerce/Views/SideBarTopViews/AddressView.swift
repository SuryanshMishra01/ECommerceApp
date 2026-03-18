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
    @State private var selectedAddress: AddressModel.ID? = nil
    
    @State private var state = ""
    @State private var street = ""
    @State private var city = ""
    @State private var pincode = ""
    @State private var phone = ""

    var body: some View {

        VStack(spacing: 20) {

            // Saved addresses
            List {
                ForEach(addVM.addressList) { address in
                    addressRow(address)
                }
                .onDelete { indexSet in
                    indexSet.map { addVM.addressList[$0].id }
                        .forEach(addVM.deleteAddress)
                }
            }
            .frame(height: 220)

            Divider()

            Form {
                Section("Add New Address") {

                    TextField("Street", text: $street)
                    TextField("City", text: $city)
                    TextField("State", text: $state)
                    TextField("Pincode", text: $pincode)
                    TextField("Phone", text: $phone)

                    HStack {
                        Button("Add Address") {
                            let newAddress = AddressModel(
                                street: street,
                                city: city,
                                state: state,
                                pincode: pincode,
                                phone: phone
                            )

                            addVM.saveAddress(newAddress)

                            street = ""
                            city = ""
                            state = ""
                            pincode = ""
                            phone = ""
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Close") {
                            dismiss()
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .frame(maxWidth: 420)
        }
        .padding()
        .onAppear { addVM.loadAllAddress() }
    }

    func addressRow(_ address: AddressModel) -> some View {
        HStack {

            VStack(alignment: .leading, spacing: 4) {
                Text(address.phone)
                    .font(.headline)

                Text(address.street)

                Text("\(address.city), \(address.state) \(address.pincode)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if addVM.defaultAddress?.id == address.id {
                Label("Default", systemImage: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            addVM.setDefault(address)
        }
    }
}
