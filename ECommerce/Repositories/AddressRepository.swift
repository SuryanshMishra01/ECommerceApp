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
            return result.map{$0.toModel()}
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
        
        let addressEntity = AddressEntity.fromModel(address, context: context)
        addressEntity.user = userEntity
  
        save()
        
    }
    
    func setDefault(_ address: AddressModel){
        guard let userID = SessionManager.shared.userID else { return }

          let request: NSFetchRequest<AddressEntity> = AddressEntity.fetchRequest()
          request.predicate = NSPredicate(format: "user.userid == %@", userID)

        do {
            let addresses = try? context.fetch(request)
            
            for addr in addresses ?? [] {
                addr.isDefault = (addr.id == address.id)
            }
        }
        save()
         
    }
    
    func deleteAddress(id: UUID) {
        let request: NSFetchRequest<AddressEntity> = AddressEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        if let result = try? context.fetch(request).first {
            context.delete(result)
            
            save()
        }
    }
    
    func save(){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
