//
//  ProfileModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 11/03/26.
//

import Foundation


struct UserProfileModel{
    let id: String
    var firstName: String
    var lastName: String
    var email: String
    var addresses: [AddressModel]
}


struct AddressModel: Identifiable{
    let id : UUID 
    let street: String
    let city: String
    let state: String
    let pincode: String
    let phone: String
    let isDefault: Bool
    
    init(
           id: UUID = UUID(),   
           street: String,
           city: String,
           state: String,
           pincode: String,
           phone: String,
           isDefault: Bool = false
       ) {
           self.id = id
           self.street = street
           self.city = city
           self.state = state
           self.pincode = pincode
           self.phone = phone
           self.isDefault = isDefault
       }
}

