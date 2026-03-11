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


struct AddressModel{
    let street: String
    let city: String
    let state: String
    let pincode: String
    let phone: String
}
