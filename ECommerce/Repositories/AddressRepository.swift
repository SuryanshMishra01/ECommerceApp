//
//  AddressRepository.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 17/03/26.
//

import Foundation
internal import CoreData

class AddressRepository{
    private let context = PersistenceController.shared.context
    
    func fetchAllAddress() -> [AddressModel]{
        guard let userID = SessionManager.shared.userID else { return [] }
        let request: NSFetchRequest<AddressEntity> = AddressEntity.fetchRequest()
        request.predicate = NSPredicate(format: "user.userid == %@", userID)
        do{
            let result = try context.fetch(request)
            return result.map{AddressModel(entity: $0)}
        }catch{
            print(error)
            return []
        }

    }
    func addAddress(_ address: AddressModel){
        guard let userID = SessionManager.shared.userID else { return }
        
        let userRequest: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        userRequest.predicate = NSPredicate(format: "userid == %@", userID)
        guard let userEntity = try? context.fetch(userRequest).first else { return }
        
        let addressEntity = AddressEntity(context: context)
        addressEntity.user = userEntity
        addressEntity.phone = address.phone
        addressEntity.street = address.street
        addressEntity.city = address.city
        addressEntity.state = address.state
        addressEntity.pincode = address.pincode
        do{
            try? context.save()
        }
        
    }
}
