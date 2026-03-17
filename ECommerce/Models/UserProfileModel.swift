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
    let id = UUID()
    let street: String
    let city: String
    let state: String
    let pincode: String
    let phone: String
}

extension AddressModel{
    init (entity: AddressEntity){
        self.street = entity.street ?? ""
        self.city = entity.city ?? ""
        self.state = entity.state ?? ""
        self.pincode = entity.pincode ?? ""
        self.phone = entity.phone ?? ""
    }
}
