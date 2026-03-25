//
//  UserProfileEntity+Extension.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 11/03/26.
//


internal import CoreData

extension UserProfileEntity {

    static func fromModel(_ model: UserProfileModel,
                          context: NSManagedObjectContext) -> UserProfileEntity {

        let profile = UserProfileEntity(context: context)

        profile.userid = model.id
        profile.firstName = model.firstName
        profile.lastName = model.lastName
        profile.email = model.email
        profile.createdAt = Date()
        profile.darkMode = false
        profile.notifications = true

        for address in model.addresses {

            let addressEntity = AddressEntity.fromModel(address, context: context)

            addressEntity.user = profile
            profile.addToAddresses(addressEntity)
        }

        return profile
    }

    func toModel() -> UserProfileModel {

        let addressSet = self.addresses as? Set<AddressEntity> ?? []

        var addresses: [AddressModel] = []

        for address in addressSet {
            addresses.append(address.toModel())
        }

        return UserProfileModel(
            id: self.userid ?? "",
            firstName: self.firstName ?? "",
            lastName: self.lastName ?? "",
            email: self.email ?? "",
            addresses: addresses
        )
    }
}

extension AddressEntity {

    static func fromModel(_ model: AddressModel,
                          context: NSManagedObjectContext) -> AddressEntity {

        let address = AddressEntity(context: context)
        address.id = model.id
        address.street = model.street
        address.city = model.city
        address.state = model.state
        address.pincode = model.pincode
        address.phone = model.phone
        address.isDefault = model.isDefault

        return address
    }

    func toModel() -> AddressModel {

        return AddressModel(
            id: self.id ?? UUID(),
            street: self.street ?? "",
            city: self.city ?? "",
            state: self.state ?? "",
            pincode: self.pincode ?? "",
            phone: self.phone ?? "",
            isDefault: self.isDefault
        )
    }
}
